//
//  AetherAVPEnvironmentEngine.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/5/26.
//
//  Apple Vision Pro implementation of the AetherCircle environment engine
//

// MARK: Import

import AetherCircleCore

// MARK: Class

/// Apple Vision Pro implementation of the AetherCircle environment engine.
public final class AetherAVPEnvironmentEngine: AetherEnvironmentEngine {

    // MARK: Properties

    /// Current immersive environment mode requested by the application.
    public var mode: AetherEnvironmentMode {
        didSet {
            applyMode()
        }
    }

    /// Runtime receiving environment changes on the main actor.
    private let runtime: AetherAVPRuntime

    // MARK: Initialization

    /// Creates an environment engine connected to an Apple Vision Pro runtime.
    ///
    /// - Parameter runtime: Runtime receiving environment changes.
    @MainActor
    public init(
        runtime: AetherAVPRuntime
    ) {
        self.runtime = runtime
        mode = .passthrough
    }

    // MARK: Private

    /// Applies the current environment mode to the runtime.
    private func applyMode() {
        let mode = mode

        Task { @MainActor [weak runtime] in
            runtime?.applyEnvironmentMode(mode)
        }
    }
}
