//
//  AetherAVPAssetEngine.swift
//  AetherCircleAVP
//
//  Created by Steve Sheets on 9/16/26.
//
//  Apple Vision Pro implementation of the AetherCircle asset engine
//

import AetherCircleCore

/// Apple Vision Pro material registry used to resolve Core material identifiers.
public final class AetherAVPAssetEngine: AetherAssetEngine {

    private var colors: [Int: AetherColor]
    private var finishes: [Int: AetherMaterialFinish]

    /// Creates an asset engine with the standard AetherCircle colors registered.
    public init() {
        colors = [:]
        finishes = [:]
        registerAllBaseColors()
    }

    /// Registers a color and finish for a Core material identifier.
    public func registerColor(
        material: Int,
        color: AetherColor,
        finish: AetherMaterialFinish
    ) {
        colors[material] = color
        finishes[material] = finish
    }

    /// Returns the registered color, falling back to black.
    func color(
        for material: Int
    ) -> AetherColor {
        colors[material] ?? .black
    }

    /// Returns the registered finish, falling back to the base finish.
    func finish(
        for material: Int
    ) -> AetherMaterialFinish {
        finishes[material] ?? .base
    }
}
