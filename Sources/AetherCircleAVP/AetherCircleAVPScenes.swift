//
//  AetherCircleAVPScenes.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/5/26.
//
//  SwiftUI immersive scene host for an AetherCircle Apple Vision Pro application
//

// MARK: Import

import SwiftUI
import AetherCircleCore

// MARK: Type Alias

/// Builder that creates an AetherCircle application for an installed AVP platform.
public typealias AetherAVPApplicationBuilder =
    @MainActor (_ platform: AetherPlatform) -> AetherApplication

// MARK: Structure

/// SwiftUI immersive scene host for an AetherCircle Apple Vision Pro application.
@MainActor
public struct AetherCircleAVPScenes: Scene {
    
    // MARK: Properties
    
    /// Runtime shared by the platform engines and RealityView.
    @State private var runtime: AetherAVPRuntime
    
    /// Application started when the immersive view appears.
    private let application: AetherApplication
    
    // MARK: Initialization
    
    /// Creates immersive Apple Vision Pro scenes for an AetherCircle application.
    ///
    /// - Parameter application: Builder receiving the installed AVP platform.
    public init(
        application: AetherAVPApplicationBuilder
    ) {
        let runtime = AetherAVPRuntime()
        let platform = AetherAVPPlatform(
            runtime: runtime
        )
        
        _runtime = State(
            initialValue: runtime
        )
        
        self.application = application(
            platform
        )
    }
    
    // MARK: Body
    
    /// SwiftUI scene content supplied to the visionOS application.
    public var body: some Scene {
        @Bindable var runtime = runtime
        
        ImmersiveSpace(
            id: "AetherCircleImmersiveSpace"
        ) {
            AetherAVPImmersiveView(
                runtime: runtime,
                application: application
            )
        }
        .immersionStyle(
            selection: $runtime.immersionStyle,
            in: .mixed,
            .full
        )
    }
    
}
