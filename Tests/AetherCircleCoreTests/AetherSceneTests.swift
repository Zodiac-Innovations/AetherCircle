//
//  AetherSceneTests.swift
//  AetherCircleCoreTests
//
//  Created by Steve Sheets on 8/11/26.
//
//  Unit tests for AetherCircle scenes and scene object management
//

// MARK: Import

import Testing
@testable import AetherCircleCore

// MARK: Tests

/// Unit tests for AetherCircle scenes and scene object management.
@Suite
struct AetherSceneTests {
    
    // MARK: Initialization Tests
    
    /// Verifies that a newly created scene stores its supplied name.
    @Test
    func sceneInitializationStoresName() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        #expect(scene.name == "Test Scene")
    }
    
    /// Verifies that a newly created scene begins without objects by default.
    @Test
    func sceneStartsEmpty() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        #expect(scene.objects.isEmpty)
    }
    
    /// Verifies that a scene can be initialized with existing objects.
    @Test
    func sceneInitializationWithObjects() {
        let cube = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        let sphere = AetherObject.sphere(
            name: "Sphere",
            diameter: 0.25
        )
        
        let scene = AetherScene(
            name: "Test Scene",
            objects: [
                cube,
                sphere,
            ]
        )
        
        #expect(scene.objects.count == 2)
        #expect(scene.objects[0] === cube)
        #expect(scene.objects[1] === sphere)
    }
    
    // MARK: Identity Tests
    
    /// Verifies that separately created scenes receive different identifiers.
    @Test
    func scenesHaveUniqueIdentifiers() {
        let first = AetherScene(
            name: "First"
        )
        
        let second = AetherScene(
            name: "Second"
        )
        
        #expect(first.id != second.id)
    }
    
    // MARK: Name Tests
    
    /// Verifies that a scene name can be changed after creation.
    @Test
    func sceneNameCanChange() {
        let scene = AetherScene(
            name: "Original"
        )
        
        scene.name = "Changed"
        
        #expect(scene.name == "Changed")
    }
    
    // MARK: Add Tests
    
    /// Verifies that an object can be added to a scene.
    @Test
    func sceneAddsObject() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let cube = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        scene.add(cube)
        
        #expect(scene.objects.count == 1)
        #expect(scene.objects.first === cube)
    }
    
    /// Verifies that multiple objects are retained in the order they are added.
    @Test
    func sceneAddsMultipleObjectsInOrder() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let first = AetherObject.cube(
            name: "First",
            size: 0.25
        )
        
        let second = AetherObject.sphere(
            name: "Second",
            diameter: 0.25
        )
        
        let third = AetherObject.cube(
            name: "Third",
            size: 0.50
        )
        
        scene.add(first)
        scene.add(second)
        scene.add(third)
        
        #expect(scene.objects.count == 3)
        #expect(scene.objects[0] === first)
        #expect(scene.objects[1] === second)
        #expect(scene.objects[2] === third)
    }
    
    /// Verifies that adding the same object instance more than once creates multiple scene entries.
    @Test
    func sceneAllowsSameObjectToBeAddedMoreThanOnce() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let cube = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        scene.add(cube)
        scene.add(cube)
        
        #expect(scene.objects.count == 2)
        #expect(scene.objects[0] === cube)
        #expect(scene.objects[1] === cube)
    }
    
    // MARK: Remove Tests
    
    /// Verifies that removing an object removes the matching object identifier.
    @Test
    func sceneRemovesObject() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let first = AetherObject.cube(
            name: "First",
            size: 0.25
        )
        
        let second = AetherObject.sphere(
            name: "Second",
            diameter: 0.25
        )
        
        scene.add(first)
        scene.add(second)
        
        scene.remove(first)
        
        #expect(scene.objects.count == 1)
        #expect(scene.objects.first === second)
    }
    
    /// Verifies that removing an object not present in the scene leaves the scene unchanged.
    @Test
    func sceneRemoveMissingObjectDoesNothing() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let stored = AetherObject.cube(
            name: "Stored",
            size: 0.25
        )
        
        let missing = AetherObject.cube(
            name: "Missing",
            size: 0.25
        )
        
        scene.add(stored)
        scene.remove(missing)
        
        #expect(scene.objects.count == 1)
        #expect(scene.objects.first === stored)
    }
    
    /// Verifies that removing an object removes every entry with the same identifier.
    @Test
    func sceneRemoveRemovesDuplicateEntries() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let cube = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        scene.add(cube)
        scene.add(cube)
        
        scene.remove(cube)
        
        #expect(scene.objects.isEmpty)
    }
    
    // MARK: Remove All Tests
    
    /// Verifies that removeAll removes every object from a scene.
    @Test
    func sceneRemovesAllObjects() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        scene.add(
            AetherObject.cube(
                name: "Cube",
                size: 0.25
            )
        )
        
        scene.add(
            AetherObject.sphere(
                name: "Sphere",
                diameter: 0.25
            )
        )
        
        scene.removeAll()
        
        #expect(scene.objects.isEmpty)
    }
    
    /// Verifies that removeAll is safe when the scene is already empty.
    @Test
    func sceneRemoveAllOnEmptyScene() {
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        scene.removeAll()
        
        #expect(scene.objects.isEmpty)
    }
    
}
