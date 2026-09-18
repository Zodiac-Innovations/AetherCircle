//
//  AetherApplication.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/4/26.
//
//  Base application class used by all AetherCircle applications
//

// MARK: Import

import Foundation

// MARK: Class

/// Base application class used by all AetherCircle applications.
open class AetherApplication {

    // MARK: Properties

    /// Platform with engines
    public let platform: AetherPlatform
    
    /// Unique identifier for the application instance.
    public let id: UUID

    /// Human-readable name of the application.
    public let name: String

    // MARK: Initialization

    /// Creates an AetherCircle application.
    ///
    /// - Parameters:
    ///   - name: Human-readable name of the application.
    ///   - id: Unique identifier for the application.
    public init(
        platform: AetherPlatform,
        name: String = "",
        id: UUID = UUID(),
    ) {
        self.platform = platform
        self.name = name
        self.id = id
    }

    // MARK: Lifecycle

    /// Starts the application after the platform runtime is ready.
    open func start() {
    }

    /// Stops the application before the platform runtime is released.
    open func stop() {
    }


}
