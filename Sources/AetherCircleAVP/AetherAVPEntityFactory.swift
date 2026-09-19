//
//  AetherAVPEntityFactory.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/5/26.
//
//  Conversion of AetherCircle objects into RealityKit entities
//

// MARK: Import

import RealityKit
import SwiftUI
import UIKit
import AetherCircleCore

// MARK: Enumeration

/// Conversion of AetherCircle objects into RealityKit entities.
@MainActor
enum AetherAVPEntityFactory {
    
    // MARK: Creation
    
    /// Creates a RealityKit entity representing a Core object.
    ///
    /// - Parameter object: Core object to represent.
    /// - Returns: Newly created RealityKit model entity.
    static func makeEntity(
        for object: AetherObject,
        assetEngine: AetherAVPAssetEngine
    ) -> ModelEntity {
        let entity = ModelEntity(
            mesh: makeMesh(for: object),
            materials: [
                makeMaterial(for: object, assetEngine: assetEngine),
            ]
        )
        
        entity.name = object.name
        update(
            entity,
            from: object,
            assetEngine: assetEngine
        )
        
        return entity
    }
    
    // MARK: Update
    
    /// Applies the complete Core object state to a RealityKit entity.
    ///
    /// - Parameters:
    ///   - entity: RealityKit entity to update.
    ///   - object: Core object supplying the state.
    static func update(
        _ entity: Entity,
        from object: AetherObject,
        assetEngine: AetherAVPAssetEngine
    ) {
        entity.position = SIMD3<Float>(
            object.position.x,
            object.position.y,
            object.position.z
        )
        
        let pitch = simd_quatf(
            angle: object.rotation.x,
            axis: SIMD3<Float>(1, 0, 0)
        )
        
        let yaw = simd_quatf(
            angle: object.rotation.y,
            axis: SIMD3<Float>(0, 1, 0)
        )
        
        let roll = simd_quatf(
            angle: object.rotation.z,
            axis: SIMD3<Float>(0, 0, 1)
        )
        
        entity.orientation = yaw * pitch * roll
        entity.isEnabled = object.isVisible
        
        if let modelEntity = entity as? ModelEntity {
            modelEntity.model?.mesh = makeMesh(
                for: object
            )
            
            modelEntity.model?.materials = [
                makeMaterial(for: object, assetEngine: assetEngine),
            ]
        }

        updateInteraction(
            of: entity,
            from: object
        )
    }

    // MARK: Interaction

    /// Applies native AVP input and hover components for an object's configuration.
    private static func updateInteraction(
        of entity: Entity,
        from object: AetherObject
    ) {
        guard let config = object.config else {
            entity.components.remove(HoverEffectComponent.self)
            entity.components.remove(InputTargetComponent.self)
            entity.components.remove(CollisionComponent.self)
            return
        }

        let acceptsInput =
            config.canTarget ||
            config.typeActivate != .none ||
            config.activateAction != nil ||
            config.typeTouch != .none ||
            config.touchAction != nil

        guard acceptsInput else {
            entity.components.remove(HoverEffectComponent.self)
            entity.components.remove(InputTargetComponent.self)
            entity.components.remove(CollisionComponent.self)
            return
        }

        entity.components.set(InputTargetComponent())
        entity.generateCollisionShapes(recursive: false)

        if config.canTarget {
            entity.components.set(HoverEffectComponent())
        } else {
            entity.components.remove(HoverEffectComponent.self)
        }
    }
    
    // MARK: Mesh
    
    /// Creates a RealityKit mesh for a Core primitive.
    ///
    /// - Parameter object: Core object defining the primitive and size.
    /// - Returns: RealityKit mesh resource.
    private static func makeMesh(
        for object: AetherObject
    ) -> MeshResource {
        switch object.primitive {
        case .cube:
            return .generateBox(
                size: SIMD3<Float>(
                    object.size.x,
                    object.size.y,
                    object.size.z
                )
            )
            
        case .sphere:
            let diameter = max(
                object.size.x,
                object.size.y,
                object.size.z
            )
            
            return .generateSphere(
                radius: diameter / 2
            )

        case .space:
            return .generateBox(
                size: SIMD3<Float>(
                    object.size.x,
                    object.size.y,
                    object.size.z
                )
            )
        }
    }
    
    // MARK: Material
    
    /// Creates a RealityKit material using a Core color.
    ///
    /// - Parameter object: Core object defining the display color.
    /// - Returns: RealityKit material.
    private static func makeMaterial(
        for object: AetherObject,
        assetEngine: AetherAVPAssetEngine
    ) -> UnlitMaterial {
        let color = assetEngine.color(for: object.material)
        let alpha: AetherFloat = object.primitive == .space ? 0 : color.alpha
        var material = UnlitMaterial()
        
        material.color = .init(
            tint: UIColor(
                red: CGFloat(color.red),
                green: CGFloat(color.green),
                blue: CGFloat(color.blue),
                alpha: CGFloat(alpha)
            )
        )
        
        return material
    }
}
