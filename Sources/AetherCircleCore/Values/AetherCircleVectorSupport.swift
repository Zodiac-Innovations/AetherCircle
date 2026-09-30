//
//  AetherCircleVectorSupport.swift
//  AetherCircle
//
//  Portable values required by the shared vector drawing contract.
//

import Foundation

public typealias AetherCircleFloat = Double

/// Semantic colors that each native platform resolves using its current appearance/theme.
public enum AetherCircleSemanticColor: String, Codable, Sendable, Equatable {
    case primary
    case secondary
    case accent
    case background
    case error
    case warning
    case success
}

/// Portable color used by AetherCircle presentation capabilities.
public enum AetherCircleColor: Codable, Sendable, Equatable {
    case semantic(AetherCircleSemanticColor)
    case rgba(red: Double, green: Double, blue: Double, alpha: Double)

    public static let primary = AetherCircleColor.semantic(.primary)
    public static let secondary = AetherCircleColor.semantic(.secondary)
    public static let accent = AetherCircleColor.semantic(.accent)
    public static let background = AetherCircleColor.semantic(.background)
    public static let error = AetherCircleColor.semantic(.error)
    public static let warning = AetherCircleColor.semantic(.warning)
    public static let success = AetherCircleColor.semantic(.success)

    public static let clear = AetherCircleColor.rgba(red: 0, green: 0, blue: 0, alpha: 0)
    public static let black = AetherCircleColor.rgba(red: 0, green: 0, blue: 0, alpha: 1)
    public static let white = AetherCircleColor.rgba(red: 1, green: 1, blue: 1, alpha: 1)
    public static let red = AetherCircleColor.rgba(red: 1, green: 0, blue: 0, alpha: 1)
    public static let green = AetherCircleColor.rgba(red: 0, green: 1, blue: 0, alpha: 1)
    public static let blue = AetherCircleColor.rgba(red: 0, green: 0, blue: 1, alpha: 1)
    public static let gray = AetherCircleColor.rgba(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)

    /// Creates an explicit RGBA color. Component values are clamped to 0...1.
    public static func rgba(_ red: Double, _ green: Double, _ blue: Double, _ alpha: Double = 1) -> AetherCircleColor {
        .rgba(
            red: min(max(red, 0), 1),
            green: min(max(green, 0), 1),
            blue: min(max(blue, 0), 1),
            alpha: min(max(alpha, 0), 1)
        )
    }
}

public enum AetherCircleMaterialType: Codable, Sendable, Equatable {
    case color(AetherCircleColor)
    case registered(key: String)
    case image(name: String)
}

public struct AetherCircleMaterial: Codable, Sendable, Equatable {
    public var type: AetherCircleMaterialType

    public init(type: AetherCircleMaterialType) {
        self.type = type
    }

    public static func color(_ color: AetherCircleColor) -> AetherCircleMaterial {
        AetherCircleMaterial(type: .color(color))
    }

    public static func registered(_ key: String) -> AetherCircleMaterial {
        AetherCircleMaterial(type: .registered(key: key))
    }

    public static func image(_ name: String) -> AetherCircleMaterial {
        AetherCircleMaterial(type: .image(name: name))
    }

    public static let black = AetherCircleMaterial.color(.black)

}
