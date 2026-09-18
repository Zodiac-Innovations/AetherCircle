//
//  AetherAVPImmersiveView.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/5/26.
//
//  RealityView that displays the active AetherCircle RealityKit scene
//

// MARK: Import

import RealityKit
import SwiftUI
import AetherCircleCore

// MARK: Structure

/// RealityView that displays the active AetherCircle RealityKit scene.
@MainActor
public struct AetherAVPImmersiveView: View {
    
    // MARK: Properties
    
    /// Runtime whose root entity is displayed by the view.
    public let runtime: AetherAVPRuntime
    
    /// App specific Application
    public let application: AetherApplication
    
    // MARK: State

    /// RealityKit subscription used to receive frame updates.
    @State
    private var updateSubscription: EventSubscription?

    // MARK: Initialization
    
    /// Creates an immersive view for an AetherCircle runtime.
    ///
    /// - Parameter runtime: Runtime whose RealityKit scene is displayed.
    ///   - application: App specific Application.
    public init(
        runtime: AetherAVPRuntime,
        application: AetherApplication
    ) {
        self.runtime = runtime
        self.application = application
    }
    
    // MARK: Body
    
    /// SwiftUI content of the immersive view.
    public var body: some View {
        RealityView { content in
            application.start()

            content.add(
                runtime.rootEntity
            )
            
            updateSubscription = content.subscribe(
                to: SceneEvents.Update.self
            ) { event in
                runtime.updateFrame(
                    deltaTime: event.deltaTime
                )
            }
            
        } update: { _ in
            _ = runtime.revision
        }
        .onDisappear {
            application.stop()
        }
    }
    
}
