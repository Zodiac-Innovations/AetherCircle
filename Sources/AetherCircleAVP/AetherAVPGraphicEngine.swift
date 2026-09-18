//
//  AetherAVPGraphicEngine.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/5/26.
//
//  Apple Vision Pro implementation of the AetherCircle graphic engine
//

// MARK: Import

import Foundation
import AetherCircleCore

// MARK: Class

/// Apple Vision Pro implementation of the AetherCircle graphic engine.
public final class AetherAVPGraphicEngine: AetherGraphicEngine {

    // MARK: Properties

    /// Runtime receiving graphical changes on the main actor.
    private let runtime: AetherAVPRuntime

    // MARK: Initialization

    /// Creates a graphic engine connected to a RealityKit runtime.
    ///
    /// - Parameter runtime: Runtime receiving graphical changes.
    @MainActor
    public init(
        runtime: AetherAVPRuntime
    ) {
        self.runtime = runtime
    }

    // MARK: AetherGraphicEngine

    /// Replaces the active native scene.
    nonisolated public func changeToScene(
        _ scene: AetherScene,
        effect: AetherEffect
    ) {
        if Thread.isMainThread {
            MainActor.assumeIsolated { [runtime] in
                runtime.changeToScene(
                    scene,
                    effect: effect
                )
            }
            return
        }

        Task { @MainActor [runtime] in
            runtime.changeToScene(
                scene,
                effect: effect
            )
        }
    }

    /// Adds an object to the active native scene.
    nonisolated public func changeAddObject(
        _ object: AetherObject,
        effect: AetherEffect
    ) {
        if Thread.isMainThread {
            MainActor.assumeIsolated { [runtime] in
                runtime.changeAddObject(
                    object,
                    effect: effect
                )
            }
            return
        }

        Task { @MainActor [runtime] in
            runtime.changeAddObject(
                object,
                effect: effect
            )
        }
    }

    /// Removes an object from the active native scene.
    nonisolated public func changeRemoveObject(
        _ object: AetherObject,
        effect: AetherEffect
    ) {
        if Thread.isMainThread {
            MainActor.assumeIsolated { [runtime] in
                runtime.changeRemoveObject(
                    object,
                    effect: effect
                )
            }
            return
        }

        Task { @MainActor [runtime] in
            runtime.changeRemoveObject(
                object,
                effect: effect
            )
        }
    }
}
