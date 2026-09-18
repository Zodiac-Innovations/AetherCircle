//
//  AetherEngineTests.swift
//  AetherCircleCoreTests
//
//  Created by Steve Sheets on 8/11/26.
//
//  Unit tests for AetherCircle engine protocols, dummy engines, and platform engine wiring
//

// MARK: Import

import Foundation
import Testing
@testable import AetherCircleCore

// MARK: Tests

/// Unit tests for AetherCircle vector values and semantic vector aliases.
@Suite
struct AetherEngineTests {
    
    /// Test implementation of AetherGraphicEngine used to verify graphic engine behavior.
    private final class TestGraphicEngine: AetherGraphicEngine {
        
        // MARK: Properties
        
        /// Scene most recently supplied to changeToScene.
        private(set) var changedScene: AetherScene?
        
        /// Effect most recently supplied to changeToScene.
        private(set) var changedSceneEffect: AetherEffect?
        
        /// Object most recently supplied to changeAddObject.
        private(set) var addedObject: AetherObject?
        
        /// Effect most recently supplied to changeAddObject.
        private(set) var addedObjectEffect: AetherEffect?
        
        /// Object most recently supplied to changeRemoveObject.
        private(set) var removedObject: AetherObject?
        
        /// Effect most recently supplied to changeRemoveObject.
        private(set) var removedObjectEffect: AetherEffect?
        
        // MARK: AetherGraphicEngine
        
        /// Records a scene change for verification.
        func changeToScene(
            _ scene: AetherScene,
            effect: AetherEffect
        ) {
            changedScene = scene
            changedSceneEffect = effect
        }
        
        /// Records an object addition for verification.
        func changeAddObject(
            _ object: AetherObject,
            effect: AetherEffect
        ) {
            addedObject = object
            addedObjectEffect = effect
        }
        
        /// Records an object removal for verification.
        func changeRemoveObject(
            _ object: AetherObject,
            effect: AetherEffect
        ) {
            removedObject = object
            removedObjectEffect = effect
        }
    }
    
    /// Test implementation of AetherEnvironmentEngine.
    private final class TestEnvironmentEngine: AetherEnvironmentEngine {
        
        // MARK: Properties
        
        /// Current environment mode stored by the test engine.
        var mode: AetherEnvironmentMode = .passthrough
    }
    
    /// Test implementation of AetherHUDEngine.
    private final class TestHUDEngine: AetherHUDEngine {
        
        // MARK: Properties
        
        /// Most recently presented HUD content.
        private(set) var presentedContent: AetherHUDContent?
        
        /// Indicates whether dismiss was called.
        private(set) var didDismiss = false
        
        // MARK: AetherHUDEngine
        
        /// Records HUD content for verification.
        func present(
            _ content: AetherHUDContent
        ) {
            presentedContent = content
        }
        
        /// Records that the HUD was dismissed.
        func dismiss() {
            didDismiss = true
        }
    }
    
    /// Test implementation of AetherClockEngine.
    private final class TestClockEngine: AetherClockEngine {
        
        // MARK: Properties
        
        /// Scheduled alarms indexed by identifier.
        private var alarms: [UUID: AetherAlarm] = [:]
        
        // MARK: AetherClockEngine
        
        /// Stores an alarm for later lookup.
        func schedule(
            _ alarm: AetherAlarm
        ) {
            alarms[alarm.id] = alarm
        }
        
        /// Removes an alarm with the specified identifier.
        func cancel(
            id: UUID
        ) {
            alarms.removeValue(
                forKey: id
            )
        }
        
        /// Returns a scheduled alarm with the specified identifier.
        func event(
            id: UUID
        ) -> AetherAlarm? {
            alarms[id]
        }
    }
    
    /// Test implementation of AetherAssetEngine.
    private final class TestAssetEngine: AetherAssetEngine {
        func registerColor(
            material: Int,
            color: AetherColor,
            finish: AetherMaterialFinish
        ) { }
    }
    
    // MARK: AetherGraphicEngine Tests
    
    /// Verifies that changeToScene forwards the supplied scene and effect.
    @Test
    func graphicEngineChangesSceneWithEffect() {
        let engine = TestGraphicEngine()
        
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let effect = AetherEffect(
            type: .fade
        )
        
        engine.changeToScene(
            scene,
            effect: effect
        )
        
        #expect(engine.changedScene === scene)
        #expect(engine.changedSceneEffect == effect)
    }
    
    /// Verifies that the convenience changeToScene method uses AetherEffect.none.
    @Test
    func graphicEngineChangesSceneWithoutEffect() {
        let engine = TestGraphicEngine()
        
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        engine.changeToScene(
            scene
        )
        
        #expect(engine.changedSceneEffect != nil)
        #expect(engine.changedSceneEffect?.type == AetherEffect.EffectType.none)
    }
    
    /// Verifies that changeAddObject forwards the supplied object and effect.
    @Test
    func graphicEngineAddsObjectWithEffect() {
        let engine = TestGraphicEngine()
        
        let object = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        let effect = AetherEffect(
            type: .fade
        )
        
        engine.changeAddObject(
            object,
            effect: effect
        )
        
        #expect(engine.addedObject === object)
        #expect(engine.addedObjectEffect == effect)
    }
    
    /// Verifies that the convenience changeAddObject method uses AetherEffect.none.
    @Test
    func graphicEngineAddsObjectWithoutEffect() {
        let engine = TestGraphicEngine()
        
        let object = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        engine.changeAddObject(
            object
        )
        
        #expect(engine.addedObject === object)
        #expect(engine.addedObjectEffect?.type == AetherEffect.EffectType.none)
    }
    
    /// Verifies that changeRemoveObject forwards the supplied object and effect.
    @Test
    func graphicEngineRemovesObjectWithEffect() {
        let engine = TestGraphicEngine()
        
        let object = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        let effect = AetherEffect(
            type: .sizing
        )
        
        engine.changeRemoveObject(
            object,
            effect: effect
        )
        
        #expect(engine.removedObject === object)
        #expect(engine.removedObjectEffect == effect)
    }
    
    /// Verifies that the convenience changeRemoveObject method uses AetherEffect.none.
    @Test
    func graphicEngineRemovesObjectWithoutEffect() {
        let engine = TestGraphicEngine()
        
        let object = AetherObject.cube(
            name: "Cube",
            size: 0.25
        )
        
        engine.changeRemoveObject(
            object
        )
        
        #expect(engine.removedObject === object)
        #expect(
            engine.removedObjectEffect?.type ==
            AetherEffect.EffectType.none
        )
    }
    
    // MARK: AetherEnvironmentEngine Tests
    
    /// Verifies that an environment engine can store passthrough mode.
    @Test
    func environmentEnginePassthroughMode() {
        let engine = TestEnvironmentEngine()
        
        engine.mode = .passthrough
        
        #expect(engine.mode == .passthrough)
    }
    
    /// Verifies that an environment engine can store full virtual reality mode.
    @Test
    func environmentEngineFullVRMode() {
        let engine = TestEnvironmentEngine()
        
        engine.mode = .fullVR
        
        #expect(engine.mode == .fullVR)
    }
    
    // MARK: AetherClockEngine Tests
    
    /// Verifies that an alarm can be scheduled and retrieved.
    @Test
    func clockEngineSchedulesAlarm() {
        let engine = TestClockEngine()
        
        let alarm = AetherAlarm(
            delay: 1
        ) {
        }
        
        engine.schedule(
            alarm
        )
        
        #expect(engine.event(id: alarm.id) === alarm)
    }
    
    /// Verifies that a scheduled alarm can be cancelled.
    @Test
    func clockEngineCancelsAlarm() {
        let engine = TestClockEngine()
        
        let alarm = AetherAlarm(
            delay: 1
        ) {
        }
        
        engine.schedule(
            alarm
        )
        
        engine.cancel(
            id: alarm.id
        )
        
        #expect(engine.event(id: alarm.id) == nil)
    }
    
    /// Verifies that looking up an unknown alarm returns nil.
    @Test
    func clockEngineReturnsNilForUnknownAlarm() {
        let engine = TestClockEngine()
        
        #expect(
            engine.event(
                id: UUID()
            ) == nil
        )
    }
    
    // MARK: Dummy Engine Tests
    
    /// Verifies that the dummy graphic engine accepts Level 1 graphic operations.
    @Test
    func graphicDummyAcceptsOperations() {
        let engine = AetherGraphicDummy()
        
        let scene = AetherScene(
            name: "Test Scene"
        )
        
        let object = AetherObject.cube(
            size: 0.25
        )
        
        engine.changeToScene(
            scene
        )
        
        engine.changeAddObject(
            object
        )
        
        engine.changeRemoveObject(
            object
        )
    }
    
    /// Verifies the default environment mode of AetherEnvironmentDummy.
    @Test
    func environmentDummyDefaultMode() {
        let engine = AetherEnvironmentDummy()
        
        #expect(engine.mode == .fullVR)
    }
    
    /// Verifies that the environment dummy allows its mode to change.
    @Test
    func environmentDummyModeCanChange() {
        let engine = AetherEnvironmentDummy()
        
        engine.mode = .passthrough
        
        #expect(engine.mode == .passthrough)
    }
    
    /// Verifies that the HUD dummy accepts presentation and dismissal operations.
    @Test
    func hudDummyAcceptsOperations() {
        let engine = AetherHUDDummy()
        
        engine.present(
            .banner(
                text: "Test",
                onClose: nil
            )
        )
        
        engine.dismiss()
    }
    
    /// Verifies that the clock dummy does not retain scheduled alarms.
    @Test
    func clockDummyDoesNotRetainAlarm() {
        let engine = AetherClockDummy()
        
        let alarm = AetherAlarm(
            delay: 1
        ) {
        }
        
        engine.schedule(
            alarm
        )
        
        #expect(engine.event(id: alarm.id) == nil)
    }
    
    // MARK: AetherPlatform Tests
    
    /// Verifies that AetherPlatform retains the exact engines supplied during initialization.
    @Test
    func platformStoresEngines() {
        let graphicEngine = TestGraphicEngine()
        let environmentEngine = TestEnvironmentEngine()
        let hudEngine = TestHUDEngine()
        let clockEngine = TestClockEngine()
        let assetEngine = TestAssetEngine()
        
        let capabilities = AetherCapabilities(
            coreLevel: .level1,
            supportsPassthrough: true,
            supportsFullVR: true,
            supportsHUD: true,
            supportsClock: true
        )
        
        let platform = AetherPlatform(
            graphicEngine: graphicEngine,
            environmentEngine: environmentEngine,
            hudEngine: hudEngine,
            clockEngine: clockEngine,
            assetEngine: assetEngine,
            capabilities: capabilities
        )
        
        #expect(platform.graphicEngine === graphicEngine)
        #expect(platform.environmentEngine === environmentEngine)
        #expect(platform.hudEngine === hudEngine)
        #expect(platform.clockEngine === clockEngine)
    }
    
    /// Verifies that AetherPlatform retains the capabilities supplied during initialization.
    @Test
    func platformStoresCapabilities() {
        let capabilities = AetherCapabilities(
            coreLevel: .level1,
            supportsPassthrough: true,
            supportsFullVR: true,
            supportsHUD: false,
            supportsClock: false
        )
        
        let platform = AetherPlatform(
            graphicEngine: TestGraphicEngine(),
            environmentEngine: TestEnvironmentEngine(),
            hudEngine: TestHUDEngine(),
            clockEngine: TestClockEngine(),
            assetEngine: TestAssetEngine(),
            capabilities: capabilities
        )
        
        #expect(platform.capabilities == capabilities)
    }
    
}
