//
//  AetherVectorTests.swift
//  AetherCircleCoreTests
//
//  Created by Steve Sheets on 8/11/26.
//
//  Unit tests for AetherCircle two-dimensional, three-dimensional, and four-dimensional vectors
//

// MARK: Import

import Testing
@testable import AetherCircleCore

// MARK: Tests

/// Unit tests for AetherCircle two-dimensional, three-dimensional, and four-dimensional vectors.
@Suite
struct AetherVectorTests {
    
    // MARK: AetherVector2 Tests
    
    /// Verifies that AetherVector2 stores the values supplied during initialization.
    @Test
    func vector2Initialization() {
        let vector = AetherVector2(
            x: 1.5,
            y: -2.5
        )
        
        #expect(vector.x == 1.5)
        #expect(vector.y == -2.5)
    }
    
    /// Verifies that the zero AetherVector2 contains zero in both components.
    @Test
    func vector2Zero() {
        #expect(
            AetherVector2.zero == AetherVector2(
                x: 0,
                y: 0
            )
        )
    }
    
    /// Verifies that the one AetherVector2 contains one in both components.
    @Test
    func vector2One() {
        #expect(
            AetherVector2.one == AetherVector2(
                x: 1,
                y: 1
            )
        )
    }
    
    // MARK: AetherVector3 Tests
    
    /// Verifies that AetherVector3 stores the values supplied during initialization.
    @Test
    func vector3Initialization() {
        let vector = AetherVector3(
            x: 1.5,
            y: -2.5,
            z: 3.5
        )
        
        #expect(vector.x == 1.5)
        #expect(vector.y == -2.5)
        #expect(vector.z == 3.5)
    }
    
    /// Verifies that the zero AetherVector3 contains zero in all three components.
    @Test
    func vector3Zero() {
        #expect(
            AetherVector3.zero == AetherVector3(
                x: 0,
                y: 0,
                z: 0
            )
        )
    }
    
    /// Verifies that the one AetherVector3 contains one in all three components.
    @Test
    func vector3One() {
        #expect(
            AetherVector3.one == AetherVector3(
                x: 1,
                y: 1,
                z: 1
            )
        )
    }
    
    /// Verifies the AetherCircle upward direction convention.
    @Test
    func vector3Up() {
        #expect(
            AetherVector3.up == AetherVector3(
                x: 0,
                y: 1,
                z: 0
            )
        )
    }
    
    /// Verifies the AetherCircle downward direction convention.
    @Test
    func vector3Down() {
        #expect(
            AetherVector3.down == AetherVector3(
                x: 0,
                y: -1,
                z: 0
            )
        )
    }
    
    /// Verifies the AetherCircle left direction convention.
    @Test
    func vector3Left() {
        #expect(
            AetherVector3.left == AetherVector3(
                x: -1,
                y: 0,
                z: 0
            )
        )
    }
    
    /// Verifies the AetherCircle right direction convention.
    @Test
    func vector3Right() {
        #expect(
            AetherVector3.right == AetherVector3(
                x: 1,
                y: 0,
                z: 0
            )
        )
    }
    
    /// Verifies that forward uses the negative z-axis in AetherCircle coordinates.
    @Test
    func vector3Forward() {
        #expect(
            AetherVector3.forward == AetherVector3(
                x: 0,
                y: 0,
                z: -1
            )
        )
    }
    
    /// Verifies that backward uses the positive z-axis in AetherCircle coordinates.
    @Test
    func vector3Backward() {
        #expect(
            AetherVector3.backward == AetherVector3(
                x: 0,
                y: 0,
                z: 1
            )
        )
    }
    
    // MARK: AetherVector4 Tests
    
    /// Verifies that AetherVector4 stores the values supplied during initialization.
    @Test
    func vector4Initialization() {
        let vector = AetherVector4(
            x: 1.5,
            y: -2.5,
            z: 3.5,
            w: -4.5
        )
        
        #expect(vector.x == 1.5)
        #expect(vector.y == -2.5)
        #expect(vector.z == 3.5)
        #expect(vector.w == -4.5)
    }
    
    /// Verifies that the zero AetherVector4 contains zero in all four components.
    @Test
    func vector4Zero() {
        #expect(
            AetherVector4.zero == AetherVector4(
                x: 0,
                y: 0,
                z: 0,
                w: 0
            )
        )
    }
    
    /// Verifies that the one AetherVector4 contains one in all four components.
    @Test
    func vector4One() {
        #expect(
            AetherVector4.one == AetherVector4(
                x: 1,
                y: 1,
                z: 1,
                w: 1
            )
        )
    }
    
    // MARK: Semantic Alias Tests
    
    /// Verifies that AetherPosition3D uses the same three-component representation as AetherVector3.
    @Test
    func position3DAlias() {
        let position = AetherPosition3D(
            x: 1,
            y: 2,
            z: 3
        )
        
        #expect(position == AetherVector3(x: 1, y: 2, z: 3))
    }
    
    /// Verifies that AetherRotation3D uses the same three-component representation as AetherVector3.
    @Test
    func rotation3DAlias() {
        let rotation = AetherRotation3D(
            x: 0.1,
            y: 0.2,
            z: 0.3
        )
        
        #expect(rotation == AetherVector3(x: 0.1, y: 0.2, z: 0.3))
    }
        
    /// Verifies that AetherVelocity3D uses the same three-component representation as AetherVector3.
    @Test
    func velocity3DAlias() {
        let velocity = AetherVelocity3D(
            x: 4,
            y: 5,
            z: 6
        )
        
        #expect(velocity == AetherVector3(x: 4, y: 5, z: 6))
    }
    
    /// Verifies that AetherAcceleration3D uses the same three-component representation as AetherVector3.
    @Test
    func acceleration3DAlias() {
        let acceleration = AetherAcceleration3D(
            x: 7,
            y: 8,
            z: 9
        )
        
        #expect(acceleration == AetherVector3(x: 7, y: 8, z: 9))
    }
    
    /// Verifies that AetherRotationRate3D uses the same three-component representation as AetherVector3.
    @Test
    func rotationRate3DAlias() {
        let rotationRate = AetherRotationRate3D(
            x: 0.5,
            y: 1.0,
            z: 1.5
        )
        
        #expect(rotationRate == AetherVector3(x: 0.5, y: 1.0, z: 1.5))
    }
    
    /// Verifies that AetherSize3D uses the same three-component representation as AetherVector3.
    @Test
    func size3DAlias() {
        let size = AetherSize3D(
            x: 0.25,
            y: 0.5,
            z: 0.75
        )
        
        #expect(size == AetherVector3(x: 0.25, y: 0.5, z: 0.75))
    }
    
    /// Verifies that AetherSize2D uses the same two-component representation as AetherVector2.
    @Test
    func size2DAlias() {
        let size = AetherSize2D(
            x: 10,
            y: 20
        )
        
        #expect(size == AetherVector2(x: 10, y: 20))
    }
    
}
