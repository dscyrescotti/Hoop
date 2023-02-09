import Foundation

public protocol DefaultKeyable {
    associatedtype Value: Codable
    var name: String { get set }
    var type: Value.Type { get set }
    var defaultValue: Value { get set }
}

extension DefaultKeyable {
    var identifier: String { "app.hoop.\(name)" }
}

public struct DefaultKey<Value: Codable>: DefaultKeyable {
    public var name: String
    public var type: Value.Type
    public var defaultValue: Value

    public init(name: String, defaultValue: Value) {
        self.name = name
        self.type = Value.self
        self.defaultValue = defaultValue
    }
}
