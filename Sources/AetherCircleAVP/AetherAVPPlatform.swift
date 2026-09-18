//
//  AetherAVPPlatform.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/5/26.
//
//  Apple Vision Pro collection of AetherCircle platform engines
//

// MARK: Import

import AetherCircleCore

// MARK: Class

/// Apple Vision Pro collection of AetherCircle platform engines.
public final class AetherAVPPlatform: AetherPlatform {

    // MARK: Initialization

    /// Creates an Apple Vision Pro platform connected to a RealityKit runtime.
    ///
    /// - Parameter runtime: Runtime that owns the native RealityKit scene.
    @MainActor
    public init(
        runtime: AetherAVPRuntime
    ) {
        super.init(
            graphicEngine: AetherAVPGraphicEngine(
                runtime: runtime
            ),
            environmentEngine: AetherAVPEnvironmentEngine(
                runtime: runtime
            ),
            hudEngine: AetherHUDDummy(),
            clockEngine: AetherClockDummy(),
            assetEngine: runtime.assetEngine,
            capabilities: AetherCapabilities(
                coreLevel: .level1,
                supportsPassthrough: true,
                supportsFullVR: true,
                supportsHUD: false,
                supportsClock: false
            )
        )
    }
}
