//
//  AetherDemoRotatingCube.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/12/26.
//

// MARK: Application
// MARK: Core Application

/// Simple AetherCircle application that displays a blue cube.
nonisolated public final class AetherDemoRotatingCube: AetherApplication {

// MARK: Lifecycle

/// Creates and presents the initial Hello AetherCircle scene.
    public override func start() {
        platform.environmentEngine.mode = .passthrough
        
        platform.assetEngine.registerBaseColor(material: 1, color: .blue)
        
        let scene = AetherScene()

        let cube = AetherObject.cube(
            size: 0.25,
            material: 1
        )

        cube.position = AetherPosition3D(
            x: 0,
            y: 1.35,
            z: -1.5
        )

        cube.rotationRate = AetherRotationRate3D(
            x: 0.35,
            y: 0.7,
            z: 0.15
        )

        scene.add(cube)

        platform.graphicEngine.changeToScene(
            scene
        )
    }

}
