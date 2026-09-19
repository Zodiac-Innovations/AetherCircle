//
//  AetherDemoHello.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/11/26.
//

// MARK: Import

import Darwin

// MARK: Application
// MARK: Core Application

/// Simple AetherCircle application that displays three interactive cubes.
nonisolated public final class AetherDemoHello: AetherApplication {

    // MARK: Lifecycle

    /// Creates and presents the initial Hello AetherCircle scene.
    public override func start() {
        platform.environmentEngine.mode = .passthrough

        platform.assetEngine.registerBaseColor(
            material: 1,
            color: .red
        )
        platform.assetEngine.registerBaseColor(
            material: 2,
            color: .green
        )
        platform.assetEngine.registerBaseColor(
            material: 3,
            color: .blue
        )

        let scene = AetherScene()

        let redCube = AetherObject.cube(
            name: "Red Cube",
            size: 0.4,
            material: 1
        )
        redCube.position = AetherPosition3D(
            x: -0.6,
            y: 1.35,
            z: -1.5
        )
        redCube.config = AetherInteractionConfig(
            canTarget: true,
            activateAction: {
                exit(EXIT_SUCCESS)
            }
        )
        scene.add(redCube)

        let greenCube = AetherObject.cube(
            name: "Green Cube",
            size: 0.4,
            material: 2
        )
        greenCube.position = AetherPosition3D(
            x: 0,
            y: 1.35,
            z: -1.5
        )
        greenCube.config = AetherInteractionConfig(
            canTarget: true
        )
        scene.add(greenCube)

        let blueCube = AetherObject.cube(
            name: "Blue Cube",
            size: 0.4,
            material: 3
        )
        blueCube.position = AetherPosition3D(
            x: 0.6,
            y: 1.35,
            z: -1.5
        )
        blueCube.config = AetherInteractionConfig(
            canTarget: true
        )
        scene.add(blueCube)

        platform.graphicEngine.changeToScene(
            scene
        )
    }
}
