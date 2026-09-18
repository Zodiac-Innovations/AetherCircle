//
//  AetherPrimitive.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/4/26.
//
//  Primitive shapes supported directly by AetherCircle Core
//

// MARK: Import

import Foundation

// MARK: Enumeration

/// Primitive shape supported directly by AetherCircle Core.
public enum AetherPrimitive: String, Sendable, Codable, Hashable {

    /// Six-sided box with equal edge lengths unless separately sized.
    case cube

    /// Round three-dimensional sphere.
    case sphere

    /// Invisible three-dimensional region used for interaction.
    case space
}
