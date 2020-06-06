import Foundation

fileprivate protocol OptionalProtocol {
    var isNil: Bool { get }
}

extension Optional: OptionalProtocol {
    fileprivate var isNil: Bool {
        return self == nil
    }
}

public struct DefaultsKey<T> {
    public var key: String
    public var defaultValue: T

    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

public extension UserDefaults {
    func set<T: Codable>(value: T, forKey: DefaultsKey<T>) {
        if let value = value as? OptionalProtocol, value.isNil {
            removeObject(forKey: forKey.key)
        } else {
            let encoder = JSONEncoder()
            if let json = try? encoder.encode(value) {
                set(json, forKey: forKey.key)
            }
        }
    }

    func value<T: Codable>(forKey: DefaultsKey<T>) -> T {
        if !dictionaryRepresentation().keys.contains(forKey.key) {
            return forKey.defaultValue
        } else {
            let decoder = JSONDecoder()

            guard let data = data(forKey: forKey.key), let object = try? decoder.decode(T.self, from: data) else {
                return forKey.defaultValue
            }
            return object
        }
    }
}
