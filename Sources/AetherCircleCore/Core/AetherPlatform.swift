//
//  AetherPlatform.swift
//  AetherCircleCore
//
//  Created by Steve Sheets on 8/4/26.
//
//  Complete collection of engines and capabilities supplied by an AetherCircle platform
//

// MARK: Class

/// Complete collection of engines and capabilities supplied by an AetherCircle platform.
open class AetherPlatform {
    
    /// initalizer
    public init(
        graphicEngine: any AetherGraphicEngine,
        environmentEngine: any AetherEnvironmentEngine,
        hudEngine: any AetherHUDEngine,
        clockEngine: any AetherClockEngine,
        assetEngine: any AetherAssetEngine,
        capabilities: AetherCapabilities
    ) {
        self.graphicEngine = graphicEngine
        self.environmentEngine = environmentEngine
        self.hudEngine = hudEngine
        self.clockEngine = clockEngine
        self.assetEngine = assetEngine
        self.capabilities = capabilities
    }

    // MARK: Engines
    
    /// Graphic engine supplied by the platform.
    public let graphicEngine: any AetherGraphicEngine

    /// Environment engine supplied by the platform.
    public let environmentEngine: any AetherEnvironmentEngine

    /// Heads-up display engine supplied by the platform.
    public let hudEngine: any AetherHUDEngine

    /// Clock engine supplied by the platform.
    public let clockEngine: any AetherClockEngine
    
    /// Asset engine supplied by the platform.
    public let assetEngine: any AetherAssetEngine
    
    // MARK: Information
    
    /// Capabilities of the enviroment
    public let capabilities: AetherCapabilities

}
