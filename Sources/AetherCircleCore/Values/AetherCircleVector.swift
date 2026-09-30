//
//  AetherCircleVector.swift
//  AetherCircle
//
//  Platform-independent vector drawing definitions.
//  Keep this contract identical across projects after substituting the project prefix.
//

import Foundation

// MARK: - Geometry

/// A point in a vector drawing's local coordinate system.
public struct AetherCirclePoint: Codable, Sendable, Equatable {
    public var x: AetherCircleFloat
    public var y: AetherCircleFloat

    public init(x: AetherCircleFloat, y: AetherCircleFloat) {
        self.x = x
        self.y = y
    }
}

/// A size in a vector drawing's local coordinate system.
public struct AetherCircleSize: Codable, Sendable, Equatable {
    public var width: AetherCircleFloat
    public var height: AetherCircleFloat

    public init(width: AetherCircleFloat, height: AetherCircleFloat) {
        self.width = width
        self.height = height
    }
}

/// A rectangle in a vector drawing's local coordinate system.
public struct AetherCircleRect: Codable, Sendable, Equatable {
    public var origin: AetherCirclePoint
    public var size: AetherCircleSize

    public init(origin: AetherCirclePoint, size: AetherCircleSize) {
        self.origin = origin
        self.size = size
    }

    public init(x: AetherCircleFloat, y: AetherCircleFloat, width: AetherCircleFloat, height: AetherCircleFloat) {
        self.init(origin: AetherCirclePoint(x: x, y: y), size: AetherCircleSize(width: width, height: height))
    }
}

// MARK: - Stroke and Fill

public enum AetherCircleVectorLineCap: String, Codable, Sendable, Equatable {
    case butt
    case round
    case square
}

public enum AetherCircleVectorLineJoin: String, Codable, Sendable, Equatable {
    case miter
    case round
    case bevel
}

public enum AetherCircleVectorLinePattern: Codable, Sendable, Equatable {
    case solid
    case dashed(lengths: [AetherCircleFloat], phase: AetherCircleFloat = 0)
}

public struct AetherCircleVectorStroke: Codable, Sendable, Equatable {
    public var material: AetherCircleMaterial
    public var thickness: AetherCircleFloat
    public var pattern: AetherCircleVectorLinePattern
    public var cap: AetherCircleVectorLineCap
    public var join: AetherCircleVectorLineJoin

    public init(
        material: AetherCircleMaterial = .black,
        thickness: AetherCircleFloat = 1,
        pattern: AetherCircleVectorLinePattern = .solid,
        cap: AetherCircleVectorLineCap = .butt,
        join: AetherCircleVectorLineJoin = .miter
    ) {
        self.material = material
        self.thickness = max(0, thickness)
        self.pattern = pattern
        self.cap = cap
        self.join = join
    }

    public init(
        color: AetherCircleColor,
        thickness: AetherCircleFloat = 1,
        pattern: AetherCircleVectorLinePattern = .solid,
        cap: AetherCircleVectorLineCap = .butt,
        join: AetherCircleVectorLineJoin = .miter
    ) {
        self.init(
            material: .color(color),
            thickness: thickness,
            pattern: pattern,
            cap: cap,
            join: join
        )
    }
}

public enum AetherCircleVectorFillPattern: Codable, Sendable, Equatable {
    case material(AetherCircleMaterial)
    case solid(AetherCircleColor)
}

public struct AetherCircleVectorFill: Codable, Sendable, Equatable {
    public var pattern: AetherCircleVectorFillPattern

    public init(pattern: AetherCircleVectorFillPattern) {
        self.pattern = pattern
    }

    public init(material: AetherCircleMaterial) {
        self.pattern = .material(material)
    }

    public init(color: AetherCircleColor) {
        self.pattern = .material(.color(color))
    }
}

// MARK: - Drawing Behavior

public enum AetherCircleVectorArcDirection: String, Codable, Sendable, Equatable {
    case clockwise
    case counterclockwise
}

public enum AetherCircleVectorContentMode: String, Codable, Sendable, Equatable {
    case fit
    case fill
    case stretch
    case original
}

public enum AetherCircleVectorAlignment: String, Codable, Sendable, Equatable {
    case topLeading
    case top
    case topTrailing
    case leading
    case center
    case trailing
    case bottomLeading
    case bottom
    case bottomTrailing
}

/// Issues platform-independent drawing commands in a local coordinate system.
/// The origin is at the upper-left, positive x extends right, and positive y extends down.
public protocol AetherCircleVectorDrawingProtocol: AnyObject {
    /// The logical bounds visible to drawing commands, independent of physical output size.
    var bounds: AetherCircleRect { get }

    func drawLine(from start: AetherCirclePoint, to end: AetherCirclePoint, stroke: AetherCircleVectorStroke)
    func drawRectangle(in rect: AetherCircleRect, stroke: AetherCircleVectorStroke?, fill: AetherCircleVectorFill?)
    func drawRoundedRectangle(
        in rect: AetherCircleRect,
        cornerRadius: AetherCircleFloat,
        stroke: AetherCircleVectorStroke?,
        fill: AetherCircleVectorFill?
    )
    func drawOval(in rect: AetherCircleRect, stroke: AetherCircleVectorStroke?, fill: AetherCircleVectorFill?)

    /// Draws an arc whose zero-degree angle points right. Positive angles follow the clockwise
    /// direction of the local coordinate system unless `direction` specifies otherwise.
    func drawArc(
        center: AetherCirclePoint,
        radius: AetherCircleFloat,
        startAngle: AetherCircleFloat,
        endAngle: AetherCircleFloat,
        direction: AetherCircleVectorArcDirection,
        stroke: AetherCircleVectorStroke
    )

    func drawPolygon(
        points: [AetherCirclePoint],
        stroke: AetherCircleVectorStroke?,
        fill: AetherCircleVectorFill?
    )
    func drawQuadraticBezier(
        from start: AetherCirclePoint,
        control: AetherCirclePoint,
        to end: AetherCirclePoint,
        stroke: AetherCircleVectorStroke
    )
    func drawCubicBezier(
        from start: AetherCirclePoint,
        control1: AetherCirclePoint,
        control2: AetherCirclePoint,
        to end: AetherCirclePoint,
        stroke: AetherCircleVectorStroke
    )

    /// Draws bitmap data, optionally cropping it with `sourceRect`, into `destinationRect`.
    func drawBitmap(
        data: Data,
        sourceRect: AetherCircleRect?,
        destinationRect: AetherCircleRect,
        opacity: AetherCircleFloat
    )

    /// Offers opaque developer-defined data to a specialized drawer.
    /// Returns true when the drawer recognizes and handles the command.
    @discardableResult
    func drawSpecialData(type: String, data: String) -> Bool
}

public extension AetherCircleVectorDrawingProtocol {
    @discardableResult
    func drawSpecialData(type: String, data: String) -> Bool {
        false
    }
}

/// Reusable drawing code that can target a native drawer or a recorder.
public typealias AetherCircleVectorDrawingClosure = (_ drawer: any AetherCircleVectorDrawingProtocol) -> Void
