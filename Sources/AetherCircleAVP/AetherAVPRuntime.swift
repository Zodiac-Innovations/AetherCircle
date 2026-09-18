//
//  AetherAVPRuntime.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/5/26.
//
//  Main-actor RealityKit runtime used by the Apple Vision Pro platform engines
//

// MARK: Import

import Foundation
import Observation
import RealityKit
import SwiftUI
import AetherCircleCore

// MARK: Class

/// Main-actor RealityKit runtime used by the Apple Vision Pro platform engines.
@MainActor
@Observable
public final class AetherAVPRuntime {

    // MARK: Properties

    /// Root RealityKit entity containing the active AetherCircle scene.
    public let rootEntity: Entity

    /// Asset engine resolving Core material identifiers.
    public let assetEngine: AetherAVPAssetEngine

    /// Immersion style requested by the active environment engine.
    public var immersionStyle: ImmersionStyle

    /// Revision incremented whenever native scene contents change.
    public private(set) var revision: UInt64

    /// Core scene currently represented by the runtime.
    public private(set) var currentScene: AetherScene?

    /// RealityKit entities indexed by their Core object identifiers.
    private var entityByObjectID: [UUID: Entity]

    // MARK: Initialization

    /// Creates an empty Apple Vision Pro runtime.
    public init(
        assetEngine: AetherAVPAssetEngine = AetherAVPAssetEngine()
    ) {
        self.assetEngine = assetEngine
        rootEntity = Entity()
        rootEntity.name = "AetherCircle Root"

        immersionStyle = .mixed
        revision = 0
        currentScene = nil
        entityByObjectID = [:]
    }

    // MARK: Frame Update

    /// Advances animated Core object state and updates native RealityKit entities.
    ///
    /// - Parameter deltaTime: Elapsed time in seconds since the previous frame.
    public func updateFrame(
        deltaTime: TimeInterval
    ) {
        guard let currentScene else {
            return
        }

        let time = AetherFloat(
            deltaTime
        )

        for object in currentScene.objects {
            guard let rotationRate = object.rotationRate else {
                continue
            }

            object.rotation.x += rotationRate.x * time
            object.rotation.y += rotationRate.y * time
            object.rotation.z += rotationRate.z * time

            guard let entity = entityByObjectID[object.id] else {
                continue
            }

            updateRotation(
                of: entity,
                from: object
            )
        }
    }

    // MARK: Scene Changes

    /// Replaces the active RealityKit scene with a Core scene.
    ///
    /// - Parameters:
    ///   - scene: Core scene to represent.
    ///   - effect: Effect requested for the scene change.
    public func changeToScene(
        _ scene: AetherScene,
        effect: AetherEffect
    ) {
        rootEntity.children.removeAll()
        entityByObjectID.removeAll()

        currentScene = scene

        for object in scene.objects {
            let entity = AetherAVPEntityFactory.makeEntity(
                for: object,
                assetEngine: assetEngine
            )

            rootEntity.addChild(entity)
            entityByObjectID[object.id] = entity
        }

        revision &+= 1
    }

    /// Adds a Core object to the active RealityKit scene.
    ///
    /// - Parameters:
    ///   - object: Core object to add.
    ///   - effect: Effect requested for the object change.
    public func changeAddObject(
        _ object: AetherObject,
        effect: AetherEffect
    ) {
        guard entityByObjectID[object.id] == nil else {
            synchronizeObject(object)
            return
        }

        let entity = AetherAVPEntityFactory.makeEntity(
            for: object,
            assetEngine: assetEngine
        )

        rootEntity.addChild(entity)
        entityByObjectID[object.id] = entity
        revision &+= 1
    }

    /// Removes a Core object from the active RealityKit scene.
    ///
    /// - Parameters:
    ///   - object: Core object to remove.
    ///   - effect: Effect requested for the object change.
    public func changeRemoveObject(
        _ object: AetherObject,
        effect: AetherEffect
    ) {
        guard let entity = entityByObjectID.removeValue(
            forKey: object.id
        ) else {
            return
        }

        entity.removeFromParent()
        revision &+= 1
    }

    /// Synchronizes the complete current state of a Core object.
    ///
    /// - Parameter object: Core object whose native entity should be updated.
    public func synchronizeObject(
        _ object: AetherObject
    ) {
        guard let entity = entityByObjectID[object.id] else {
            return
        }

        AetherAVPEntityFactory.update(
            entity,
            from: object,
            assetEngine: assetEngine
        )

        revision &+= 1
    }

    // MARK: Environment

    /// Applies an AetherCircle environment mode to the immersive space.
    ///
    /// - Parameter mode: Environment mode requested by the application.
    public func applyEnvironmentMode(
        _ mode: AetherEnvironmentMode
    ) {
        switch mode {
        case .passthrough:
            immersionStyle = .mixed

        case .fullVR:
            immersionStyle = .full
        }
    }

    // MARK: Private

    /// Applies a Core Euler rotation to a RealityKit entity.
    ///
    /// - Parameters:
    ///   - entity: RealityKit entity to rotate.
    ///   - object: Core object containing the desired rotation.
    private func updateRotation(
        of entity: Entity,
        from object: AetherObject
    ) {
        let pitch = simd_quatf(
            angle: object.rotation.x,
            axis: SIMD3<Float>(
                1,
                0,
                0
            )
        )

        let yaw = simd_quatf(
            angle: object.rotation.y,
            axis: SIMD3<Float>(
                0,
                1,
                0
            )
        )

        let roll = simd_quatf(
            angle: object.rotation.z,
            axis: SIMD3<Float>(
                0,
                0,
                1
            )
        )

        entity.orientation =
            yaw *
            pitch *
            roll
    }}
