//
//  AetherDemoHello.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/11/26.
//

// MARK: Application
// MARK: Core Application

/// Simple AetherCircle application that displays HELLO.
nonisolated public final class AetherDemoHello: AetherApplication {

// MARK: Lifecycle

/// Creates and presents the initial Hello AetherCircle scene.
    public override func start() {
        platform.environmentEngine.mode = .passthrough

        platform.assetEngine.registerBaseColor(material: 1, color: .blue)

        let scene = AetherScene()

        let listPos: [AetherPosition3D] = [

            // H
            AetherPosition3D(x: -2.52, y: 1.91, z: -1.5),
            AetherPosition3D(x: -1.96, y: 1.91, z: -1.5),

            AetherPosition3D(x: -2.52, y: 1.63, z: -1.5),
            AetherPosition3D(x: -1.96, y: 1.63, z: -1.5),

            AetherPosition3D(x: -2.52, y: 1.35, z: -1.5),
            AetherPosition3D(x: -2.24, y: 1.35, z: -1.5),
            AetherPosition3D(x: -1.96, y: 1.35, z: -1.5),

            AetherPosition3D(x: -2.52, y: 1.07, z: -1.5),
            AetherPosition3D(x: -1.96, y: 1.07, z: -1.5),

            AetherPosition3D(x: -2.52, y: 0.79, z: -1.5),
            AetherPosition3D(x: -1.96, y: 0.79, z: -1.5),

            // E
            AetherPosition3D(x: -1.40, y: 1.91, z: -1.5),
            AetherPosition3D(x: -1.12, y: 1.91, z: -1.5),
            AetherPosition3D(x: -0.84, y: 1.91, z: -1.5),

            AetherPosition3D(x: -1.40, y: 1.63, z: -1.5),

            AetherPosition3D(x: -1.40, y: 1.35, z: -1.5),
            AetherPosition3D(x: -1.12, y: 1.35, z: -1.5),

            AetherPosition3D(x: -1.40, y: 1.07, z: -1.5),

            AetherPosition3D(x: -1.40, y: 0.79, z: -1.5),
            AetherPosition3D(x: -1.12, y: 0.79, z: -1.5),
            AetherPosition3D(x: -0.84, y: 0.79, z: -1.5),

            // L
            AetherPosition3D(x: -0.28, y: 1.91, z: -1.5),
            AetherPosition3D(x: -0.28, y: 1.63, z: -1.5),
            AetherPosition3D(x: -0.28, y: 1.35, z: -1.5),
            AetherPosition3D(x: -0.28, y: 1.07, z: -1.5),
            AetherPosition3D(x: -0.28, y: 0.79, z: -1.5),
            AetherPosition3D(x:  0.00, y: 0.79, z: -1.5),
            AetherPosition3D(x:  0.28, y: 0.79, z: -1.5),

            // L
            AetherPosition3D(x: 0.84, y: 1.91, z: -1.5),
            AetherPosition3D(x: 0.84, y: 1.63, z: -1.5),
            AetherPosition3D(x: 0.84, y: 1.35, z: -1.5),
            AetherPosition3D(x: 0.84, y: 1.07, z: -1.5),
            AetherPosition3D(x: 0.84, y: 0.79, z: -1.5),
            AetherPosition3D(x: 1.12, y: 0.79, z: -1.5),
            AetherPosition3D(x: 1.40, y: 0.79, z: -1.5),

            // O
            AetherPosition3D(x: 1.96, y: 1.91, z: -1.5),
            AetherPosition3D(x: 2.24, y: 1.91, z: -1.5),
            AetherPosition3D(x: 2.52, y: 1.91, z: -1.5),

            AetherPosition3D(x: 1.96, y: 1.63, z: -1.5),
            AetherPosition3D(x: 2.52, y: 1.63, z: -1.5),

            AetherPosition3D(x: 1.96, y: 1.35, z: -1.5),
            AetherPosition3D(x: 2.52, y: 1.35, z: -1.5),

            AetherPosition3D(x: 1.96, y: 1.07, z: -1.5),
            AetherPosition3D(x: 2.52, y: 1.07, z: -1.5),

            AetherPosition3D(x: 1.96, y: 0.79, z: -1.5),
            AetherPosition3D(x: 2.24, y: 0.79, z: -1.5),
            AetherPosition3D(x: 2.52, y: 0.79, z: -1.5),
        ]
        
        for pos in listPos {
            let cube = AetherObject.cube(
                size: 0.25,
                material: 1
            )
            cube.position = pos
            scene.add(cube)
        }

        platform.graphicEngine.changeToScene(
            scene
        )
    }

}
