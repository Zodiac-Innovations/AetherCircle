//
//  AetherInteraction.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/12/26.
//
//  User interaction with an AetherCircle object
//

// MARK: Import

import Foundation

// MARK: Structure

/// User interaction with an AetherCircle object.
public struct AetherInteraction: Sendable, Codable, Hashable {

    // MARK: Enumeration

    /// Type of user interaction with an object.
    public enum InteractionType: Int, Codable, Sendable {

        /// Object has gained user focus.
        case focus = 0

        /// Object has lost user focus.
        case unfocus = 1

        /// Object has been selected.
        case select = 2

        /// Object has been deselected.
        case deselect = 3

        /// Object has been activated by the user.
        case activate = 4

        /// Object has been physically touched by the user.
        case touch = 5
    }

    // MARK: Properties

    /// Type of user interaction.
    public var type: InteractionType

    // MARK: Initialization

    /// Creates a user interaction.
    ///
    /// - Parameter type: Type of interaction.
    public init(
        type: InteractionType
    ) {
        self.type = type
    }
}
