//
//  AetherValueTests.swift
//  AetherCircleCoreTests
//
//  Created by Steve Sheets on 8/11/26.
//
//  Unit tests for AetherCircle platform-independent value types
//

// MARK: Import

import Testing
@testable import AetherCircleCore

// MARK: Tests

/// Unit tests for AetherCircle platform-independent value types.
@Suite
struct AetherValueTests {

    // MARK: AetherColor Tests

    /// Verifies that AetherColor stores the values supplied during initialization.
    @Test
    func colorInitialization() {
        let color = AetherColor(
            red: 0.1,
            green: 0.2,
            blue: 0.3,
            alpha: 0.4
        )

        #expect(color.red == 0.1)
        #expect(color.green == 0.2)
        #expect(color.blue == 0.3)
        #expect(color.alpha == 0.4)
    }

    /// Verifies that AetherColor uses full opacity by default.
    @Test
    func colorDefaultAlpha() {
        let color = AetherColor(
            red: 0.1,
            green: 0.2,
            blue: 0.3
        )

        #expect(color.alpha == 1)
    }

    /// Verifies the predefined clear color.
    @Test
    func colorClear() {
        #expect(
            AetherColor.clear == AetherColor(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 0
            )
        )
    }

    /// Verifies the predefined black color.
    @Test
    func colorBlack() {
        #expect(
            AetherColor.black == AetherColor(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 1
            )
        )
    }

    /// Verifies the predefined white color.
    @Test
    func colorWhite() {
        #expect(
            AetherColor.white == AetherColor(
                red: 1,
                green: 1,
                blue: 1,
                alpha: 1
            )
        )
    }

    /// Verifies the predefined red color.
    @Test
    func colorRed() {
        #expect(
            AetherColor.red == AetherColor(
                red: 1,
                green: 0,
                blue: 0,
                alpha: 1
            )
        )
    }

    /// Verifies the predefined green color.
    @Test
    func colorGreen() {
        #expect(
            AetherColor.green == AetherColor(
                red: 0,
                green: 1,
                blue: 0,
                alpha: 1
            )
        )
    }

    /// Verifies the predefined blue color.
    @Test
    func colorBlue() {
        #expect(
            AetherColor.blue == AetherColor(
                red: 0,
                green: 0,
                blue: 1,
                alpha: 1
            )
        )
    }

    // MARK: AetherEffect Tests

    /// Verifies that the default AetherEffect has no graphical effect.
    @Test
    func effectDefaultIsNone() {
        let effect = AetherEffect()

        #expect(effect.type == .none)
    }

    /// Verifies that the predefined none effect has no graphical effect.
    @Test
    func effectNone() {
        #expect(AetherEffect.none.type == .none)
    }

    /// Verifies that a fade effect preserves its effect type.
    @Test
    func effectFade() {
        let effect = AetherEffect(
            type: .fade
        )

        #expect(effect.type == .fade)
    }

    /// Verifies that a sizing effect preserves its effect type.
    @Test
    func effectSizing() {
        let effect = AetherEffect(
            type: .sizing
        )

        #expect(effect.type == .sizing)
    }

    // MARK: AetherQuaternion Tests

    /// Verifies that AetherQuaternion stores the values supplied during initialization.
    @Test
    func quaternionInitialization() {
        let quaternion = AetherQuaternion(
            x: 0.1,
            y: 0.2,
            z: 0.3,
            w: 0.4
        )

        #expect(quaternion.x == 0.1)
        #expect(quaternion.y == 0.2)
        #expect(quaternion.z == 0.3)
        #expect(quaternion.w == 0.4)
    }

    /// Verifies that the identity quaternion represents no rotation.
    @Test
    func quaternionIdentity() {
        #expect(
            AetherQuaternion.identity == AetherQuaternion(
                x: 0,
                y: 0,
                z: 0,
                w: 1
            )
        )
    }

    // MARK: AetherEnvironmentMode Tests

    /// Verifies the passthrough environment mode raw value.
    @Test
    func environmentModePassthrough() {
        #expect(
            AetherEnvironmentMode.passthrough.rawValue == "passthrough"
        )
    }

    /// Verifies the full virtual reality environment mode raw value.
    @Test
    func environmentModeFullVR() {
        #expect(
            AetherEnvironmentMode.fullVR.rawValue == "fullVR"
        )
    }

    // MARK: AetherPrimitive Tests

    /// Verifies the cube primitive raw value.
    @Test
    func primitiveCube() {
        #expect(
            AetherPrimitive.cube.rawValue == "cube"
        )
    }

    /// Verifies the sphere primitive raw value.
    @Test
    func primitiveSphere() {
        #expect(
            AetherPrimitive.sphere.rawValue == "sphere"
        )
    }

    // MARK: AetherHUDContent Tests

    /// Verifies that banner HUD content preserves its text.
    @Test
    func hudContentBanner() {
        let content = AetherHUDContent.banner(
            text: "Hello AetherCircle",
            onClose: nil
        )

        switch content {
        case .banner(
            let text,
            _
        ):
            #expect(text == "Hello AetherCircle")

        default:
            Issue.record(
                "Expected banner HUD content."
            )
        }
    }

    /// Verifies that action HUD content preserves its text and button title.
    @Test
    func hudContentAction() {
        let content = AetherHUDContent.action(
            text: "Continue?",
            buttonTitle: "Next"
        ) {
        }

        switch content {
        case .action(
            let text,
            let buttonTitle,
            _
        ):
            #expect(text == "Continue?")
            #expect(buttonTitle == "Next")

        default:
            Issue.record(
                "Expected action HUD content."
            )
        }
    }

    // MARK: AetherSupportLevel Tests

    /// Verifies that Level 1 has the expected raw value.
    @Test
    func supportLevelOne() {
        #expect(
            AetherSupportLevel.level1.rawValue == 1
        )
    }

    // MARK: AetherCapabilities Tests

    /// Verifies that AetherCapabilities preserves the supplied support level.
    @Test
    func capabilitiesSupportLevel() {
        let capabilities = AetherCapabilities(
            coreLevel: .level1,
            supportsPassthrough: true,
            supportsFullVR: true,
            supportsHUD: false,
            supportsClock: false
        )

        #expect(capabilities.coreLevel == .level1)
    }

    /// Verifies that AetherCapabilities preserves supported platform features.
    @Test
    func capabilitiesSupportedFeatures() {
        let capabilities = AetherCapabilities(
            coreLevel: .level1,
            supportsPassthrough: true,
            supportsFullVR: true,
            supportsHUD: true,
            supportsClock: true
        )

        #expect(capabilities.supportsPassthrough)
        #expect(capabilities.supportsFullVR)
        #expect(capabilities.supportsHUD)
        #expect(capabilities.supportsClock)
    }

    /// Verifies that AetherCapabilities preserves unsupported platform features.
    @Test
    func capabilitiesUnsupportedFeatures() {
        let capabilities = AetherCapabilities(
            coreLevel: .level1,
            supportsPassthrough: false,
            supportsFullVR: false,
            supportsHUD: false,
            supportsClock: false
        )

        #expect(capabilities.supportsPassthrough == false)
        #expect(capabilities.supportsFullVR == false)
        #expect(capabilities.supportsHUD == false)
        #expect(capabilities.supportsClock == false)
    }

}
