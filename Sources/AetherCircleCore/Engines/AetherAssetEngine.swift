//
//  AetherAssetEngine.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/13/26.
//
//  Platform engine contract for managing assets and materials
//

// MARK: Import

import Foundation

//// MARK: Constants
//
///// Base Black standard material number
//public let baseBlack = 0
//
///// Base White standard material number
//public let baseWhite = 1
//
///// Base Red standard material number
//public let baseRed = 2
//
///// Base Green standard material number
//public let baseGreen = 3
//
///// Base Blue standard material number
//public let baseBlue = 4
//


// MARK: Enumeration

/// Surface finish applied to a registered material.
public enum AetherMaterialFinish: Int, Codable, Sendable {

    /// Basic/default surface finish.
    case base = 0

    /// Glossy reflective surface finish.
    case glossy = 1

    /// Dull low-reflectivity surface finish.
    case dull = 2
}

// MARK: Material

/// Standard AetherCircle material identifiers.
public enum AetherStandardMaterial {

    /// Base black standard material.
    public static let baseBlack = 0

    /// Base white standard material.
    public static let baseWhite = 1

    /// Base red standard material.
    public static let baseRed = 2

    /// Base green standard material.
    public static let baseGreen = 3

    /// Base blue standard material.
    public static let baseBlue = 4
}

// MARK: Protocol

/// Platform engine contract for managing assets and materials.
public protocol AetherAssetEngine: AetherEngine {
    
    /// Registers a color material.
    ///
    /// - Parameters:
    ///   - material: Unique integer identifying the material.
    ///   - color: Color of the material.
    ///   - finish: Surface finish of the material.
    func registerColor(
        material: Int,
        color: AetherColor,
        finish: AetherMaterialFinish
    )
    
}

// MARK: Extension

public extension AetherAssetEngine {
    
    /// Registers a color material using the base finish.
    ///
    /// - Parameters:
    ///   - material: Unique integer identifying the material.
    ///   - color: Color of the material.
    func registerBaseColor(
        material: Int,
        color: AetherColor
    ) {
        registerColor(
            material: material,
            color: color,
            finish: .base
        )
    }
    
    /// Register standard colors with base finish
    func registerAllBaseColors() {
        registerColor(material: AetherStandardMaterial.baseBlack, color: .black, finish: .base)
        registerColor(material: AetherStandardMaterial.baseWhite, color: .white, finish: .base)
        registerColor(material: AetherStandardMaterial.baseRed, color: .red, finish: .base)
        registerColor(material: AetherStandardMaterial.baseGreen, color: .green, finish: .base)
        registerColor(material: AetherStandardMaterial.baseBlue, color: .blue, finish: .base)
    }

}

// MARK: Class

/// Place Holder Asset Engine.
public final class AetherAssetDummy: AetherAssetEngine {

    // MARK: Init
    
    public init() {}

    // MARK: AetherAssetEngine
    
    public func registerColor(material: Int, color: AetherColor, finish: AetherMaterialFinish) { }
}

