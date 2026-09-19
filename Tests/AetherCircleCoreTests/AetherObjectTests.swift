//
//  AetherObjectTests.swift
//  AetherCircleCoreTests
//
//  Created by Steve Sheets on 8/11/26.
//
//  Unit tests for AetherCircle scene objects and primitive convenience constructors
//

// MARK: Import

import Testing
@testable import AetherCircleCore

// MARK: Tests

/// Unit tests for AetherCircle scene objects and primitive convenience constructors.
@Suite
struct AetherObjectTests {
    
    // MARK: Initialization Tests
    
    /// Verifies that an AetherObject stores values supplied during initialization.
    @Test
    func objectInitialization() {
        let object = AetherObject(
            name: "Test Object",
            primitive: .cube,
            position: AetherPosition3D(
                x: 1,
                y: 2,
                z: 3
            ),
            rotation: AetherRotation3D(
                x: 0.1,
                y: 0.2,
                z: 0.3
            ),
            size: AetherSize3D(
                x: 0.25,
                y: 0.5,
                z: 0.75
            ),
            material: 2,
            isVisible: false,
            velocity: AetherVelocity3D(
                x: 1,
                y: 2,
                z: 3
            ),
            acceleration: AetherAcceleration3D(
                x: 4,
                y: 5,
                z: 6
            ),
            rotationRate: AetherRotationRate3D(
                x: 0.4,
                y: 0.5,
                z: 0.6
            )
        )
        
        #expect(object.name == "Test Object")
        #expect(object.primitive == .cube)
        
        #expect(
            object.position == AetherPosition3D(
                x: 1,
                y: 2,
                z: 3
            )
        )
        
        #expect(
            object.rotation == AetherRotation3D(
                x: 0.1,
                y: 0.2,
                z: 0.3
            )
        )
                
        #expect(
            object.size == AetherSize3D(
                x: 0.25,
                y: 0.5,
                z: 0.75
            )
        )
        
        #expect(object.isVisible == false)
        
        #expect(
            object.velocity == AetherVelocity3D(
                x: 1,
                y: 2,
                z: 3
            )
        )
        
        #expect(
            object.acceleration == AetherAcceleration3D(
                x: 4,
                y: 5,
                z: 6
            )
        )
        
        #expect(
            object.rotationRate == AetherRotationRate3D(
                x: 0.4,
                y: 0.5,
                z: 0.6
            )
        )
    }
    
    /// Verifies the default state of a newly initialized AetherObject.
    @Test
    func objectDefaultValues() {
        let object = AetherObject(
            name: "Default Object",
            primitive: .cube
        )
        
        #expect(object.position == .zero)
        #expect(object.rotation == .zero)
        #expect(object.size == .one)
        #expect(object.isVisible)
        #expect(object.config == nil)
        #expect(object.velocity == nil)
        #expect(object.acceleration == nil)
        #expect(object.rotationRate == nil)
    }
    
    /// Verifies that an object stores its interaction configuration and invokes its actions.
    @Test
    func objectInteractionConfiguration() {
        var activationCount = 0
        var touchState: Bool?

        let config = AetherInteractionConfig(
            canTarget: true,
            typeActivate: .enlarge(10),
            activateAction: { activationCount += 1 },
            typeTouch: .glow,
            touchAction: { touchState = $0 }
        )

        let object = AetherObject(
            name: "Interactive Object",
            primitive: .cube,
            config: config
        )

        #expect(object.config?.canTarget == true)
        #expect(object.config?.typeActivate == .enlarge(10))
        #expect(object.config?.typeTouch == .glow)

        object.config?.activateAction?()
        object.config?.touchAction?(false)

        #expect(activationCount == 1)
        #expect(touchState == false)
    }

    // MARK: Identity Tests
    
    /// Verifies that separately created AetherObjects receive different identifiers.
    @Test
    func objectsHaveUniqueIdentifiers() {
        let first = AetherObject(
            name: "First",
            primitive: .cube
        )
        
        let second = AetherObject(
            name: "Second",
            primitive: .cube
        )
        
        #expect(first.id != second.id)
    }
    
    // MARK: Cube Tests
    
    /// Verifies that the cube convenience constructor creates a cube primitive.
    @Test
    func cubePrimitive() {
        let cube = AetherObject.cube(
            name: "Test Cube",
            size: 0.25
        )
        
        #expect(cube.primitive == .cube)
    }
    
    /// Verifies that the cube convenience constructor preserves its name.
    @Test
    func cubeName() {
        let cube = AetherObject.cube(
            name: "Test Cube",
            size: 0.25
        )
        
        #expect(cube.name == "Test Cube")
    }
    
    /// Verifies that the cube convenience constructor applies its size equally to all three dimensions.
    @Test
    func cubeSize() {
        let cube = AetherObject.cube(
            size: 0.25
        )
        
        #expect(
            cube.size == AetherSize3D(
                x: 0.25,
                y: 0.25,
                z: 0.25
            )
        )
    }
    
    /// Verifies that the cube convenience constructor preserves the specified color.
    @Test
    func cubeColor() {
        let cube = AetherObject.cube(
            size: 0.25,
            material: 4
        )
        
        #expect(cube.material == 4)
    }
    
    /// Verifies the default state of an object created by the cube convenience constructor.
    @Test
    func cubeDefaultValues() {
        let cube = AetherObject.cube(
            size: 0.25
        )
        
        #expect(cube.position == .zero)
        #expect(cube.rotation == .zero)
        #expect(cube.isVisible)
        #expect(cube.velocity == nil)
        #expect(cube.acceleration == nil)
        #expect(cube.rotationRate == nil)
    }
    
    // MARK: Sphere Tests
    
    /// Verifies that the sphere convenience constructor creates a sphere primitive.
    @Test
    func spherePrimitive() {
        let sphere = AetherObject.sphere(
            name: "Test Sphere",
            diameter: 0.4
        )
        
        #expect(sphere.primitive == .sphere)
    }
    
    /// Verifies that the sphere convenience constructor preserves its name.
    @Test
    func sphereName() {
        let sphere = AetherObject.sphere(
            name: "Test Sphere",
            diameter: 0.4
        )
        
        #expect(sphere.name == "Test Sphere")
    }
    
    /// Verifies that the sphere convenience constructor applies its diameter equally to all three dimensions.
    @Test
    func sphereSize() {
        let sphere = AetherObject.sphere(
            diameter: 0.4
        )
        
        #expect(
            sphere.size == AetherSize3D(
                x: 0.4,
                y: 0.4,
                z: 0.4
            )
        )
    }
    
    /// Verifies that the sphere convenience constructor preserves the specified color.
    @Test
    func sphereColor() {
        let sphere = AetherObject.sphere(
            diameter: 0.4,
            material: 4
        )
        
        #expect(sphere.material == 4)
    }
    
    /// Verifies the default state of an object created by the sphere convenience constructor.
    @Test
    func sphereDefaultValues() {
        let sphere = AetherObject.sphere(
            diameter: 0.4
        )
        
        #expect(sphere.position == .zero)
        #expect(sphere.rotation == .zero)
        #expect(sphere.isVisible)
        #expect(sphere.velocity == nil)
        #expect(sphere.acceleration == nil)
        #expect(sphere.rotationRate == nil)
    }
    
    // MARK: Mutation Tests
    
    /// Verifies that an object's position can be changed after creation.
    @Test
    func objectPositionCanChange() {
        let object = AetherObject.cube(
            size: 0.25
        )
        
        object.position = AetherPosition3D(
            x: 1,
            y: 2,
            z: -3
        )
        
        #expect(
            object.position == AetherPosition3D(
                x: 1,
                y: 2,
                z: -3
            )
        )
    }
    
    /// Verifies that an object's appearance values can be changed after creation.
    @Test
    func objectAppearanceCanChange() {
        let object = AetherObject.cube(
            size: 0.25,
            material: 0
        )
        
        object.material = 0
        object.isVisible = false
        
        #expect(object.material == 0)
        #expect(object.isVisible == false)
    }
    
    /// Verifies that an object's motion values can be changed after creation.
    @Test
    func objectMotionCanChange() {
        let object = AetherObject.cube(
            size: 0.25
        )
        
        object.velocity = AetherVelocity3D(
            x: 1,
            y: 0,
            z: -2
        )
        
        object.acceleration = AetherAcceleration3D(
            x: 0,
            y: -9.8,
            z: 0
        )
        
        object.rotationRate = AetherRotationRate3D(
            x: 0.1,
            y: 0.2,
            z: 0.3
        )
        
        #expect(
            object.velocity == AetherVelocity3D(
                x: 1,
                y: 0,
                z: -2
            )
        )
        
        #expect(
            object.acceleration == AetherAcceleration3D(
                x: 0,
                y: -9.8,
                z: 0
            )
        )
        
        #expect(
            object.rotationRate == AetherRotationRate3D(
                x: 0.1,
                y: 0.2,
                z: 0.3
            )
        )
    }
    
}
