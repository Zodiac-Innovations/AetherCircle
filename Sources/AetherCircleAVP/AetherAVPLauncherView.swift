//
//  AetherAVPLauncherView.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 8/11/26.
//
//  Launch window that opens the AetherCircle immersive space
//

// MARK: Import

import SwiftUI

// MARK: Structure

/// Launch window that opens the AetherCircle immersive space.
@MainActor
public struct AetherAVPLauncherView: View {

    // MARK: Environment

    /// System action used to open the AetherCircle immersive space.
    @Environment(\.openImmersiveSpace)
    private var openImmersiveSpace

    /// System action used to close the temporary launch window.
    @Environment(\.dismissWindow)
    private var dismissWindow

    // MARK: State

    /// Indicates whether the immersive space has already been requested.
    @State private var hasOpenedImmersiveSpace = false

    // MARK: Initialization

    /// Creates the AetherCircle launcher view.
    public init() {
    }

    // MARK: Body

    /// Transparent content displayed while launching the immersive space.
    public var body: some View {
        Color.clear
            .frame(
                width: 1,
                height: 1
            )
            .task {
                guard hasOpenedImmersiveSpace == false else {
                    return
                }

                hasOpenedImmersiveSpace = true

                let result = await openImmersiveSpace(
                    id: "AetherCircleImmersiveSpace"
                )

                switch result {
                case .opened:
                    await Task.yield()
                    dismissWindow(
                        id: "AetherCircleLauncher"
                    )

                case .error, .userCancelled:
                    hasOpenedImmersiveSpace = false

                @unknown default:
                    hasOpenedImmersiveSpace = false
                }
            }
    }
}
