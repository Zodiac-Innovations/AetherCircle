import AetherCircleCore

private final class QuestGraphicEngine: AetherGraphicEngine {
    var scene = AetherScene()

    func changeToScene(
        _ scene: AetherScene,
        effect: AetherEffect
    ) {
        self.scene = scene
    }

    func changeAddObject(
        _ object: AetherObject,
        effect: AetherEffect
    ) {
        scene.add(object)
    }

    func changeRemoveObject(
        _ object: AetherObject,
        effect: AetherEffect
    ) {
        scene.remove(object)
    }
}

private final class QuestEnvironmentEngine: AetherEnvironmentEngine {
    var mode: AetherEnvironmentMode = .fullVR
}

private final class QuestAssetEngine: AetherAssetEngine {
    private(set) var colors: [Int: AetherColor] = [:]

    init() {
        registerAllBaseColors()
    }

    func registerColor(
        material: Int,
        color: AetherColor,
        finish: AetherMaterialFinish
    ) {
        colors[material] = color
    }

    func color(for material: Int) -> AetherColor {
        colors[material] ?? .black
    }
}

private final class QuestSwiftRuntime: @unchecked Sendable {
    static let shared = QuestSwiftRuntime()

    let graphicEngine = QuestGraphicEngine()
    let environmentEngine = QuestEnvironmentEngine()
    let assetEngine = QuestAssetEngine()
    private var application: AetherApplication?

    private init() {
    }

    func start() {
        guard application == nil else {
            return
        }

        let platform = AetherPlatform(
            graphicEngine: graphicEngine,
            environmentEngine: environmentEngine,
            hudEngine: AetherHUDDummy(),
            clockEngine: AetherClockDummy(),
            assetEngine: assetEngine,
            capabilities: AetherCapabilities(
                coreLevel: .level1,
                supportsPassthrough: true,
                supportsFullVR: true,
                supportsHUD: false,
                supportsClock: false
            )
        )
        let application = {{PROJECT_NAME}}Application(
            platform: platform,
            name: "{{DISPLAY_NAME_CPP}}"
        )
        self.application = application
        application.start()
    }

    func stop() {
        application?.stop()
        application = nil
    }

    func object(at index: Int32) -> AetherObject? {
        let objects = graphicEngine.scene.objects
        guard index >= 0, Int(index) < objects.count else {
            return nil
        }
        return objects[Int(index)]
    }
}

@_cdecl("aethercircle_swift_start")
public func aethercircleSwiftStart() {
    QuestSwiftRuntime.shared.start()
}

@_cdecl("aethercircle_swift_stop")
public func aethercircleSwiftStop() {
    QuestSwiftRuntime.shared.stop()
}

@_cdecl("aethercircle_swift_object_count")
public func aethercircleSwiftObjectCount() -> Int32 {
    Int32(QuestSwiftRuntime.shared.graphicEngine.scene.objects.count)
}

@_cdecl("aethercircle_swift_object_primitive")
public func aethercircleSwiftObjectPrimitive(_ index: Int32) -> Int32 {
    guard let object = QuestSwiftRuntime.shared.object(at: index) else {
        return -1
    }
    switch object.primitive {
    case .cube: return 0
    case .sphere: return 1
    case .space: return 2
    }
}

@_cdecl("aethercircle_swift_object_value")
public func aethercircleSwiftObjectValue(
    _ index: Int32,
    _ value: Int32
) -> Float {
    guard let object = QuestSwiftRuntime.shared.object(at: index) else {
        return 0
    }

    switch value {
    case 0: return object.position.x
    case 1: return object.position.y
    case 2: return object.position.z
    case 3: return object.size.x
    case 4: return object.size.y
    case 5: return object.size.z
    case 6: return object.rotation.x
    case 7: return object.rotation.y
    case 8: return object.rotation.z
    case 9: return object.rotationRate?.x ?? 0
    case 10: return object.rotationRate?.y ?? 0
    case 11: return object.rotationRate?.z ?? 0
    default: return 0
    }
}

@_cdecl("aethercircle_swift_object_color")
public func aethercircleSwiftObjectColor(
    _ index: Int32,
    _ component: Int32
) -> Float {
    guard let object = QuestSwiftRuntime.shared.object(at: index) else {
        return 0
    }
    let color = QuestSwiftRuntime.shared.assetEngine.color(
        for: object.material
    )
    switch component {
    case 0: return color.red
    case 1: return color.green
    case 2: return color.blue
    case 3: return color.alpha
    default: return 0
    }
}
