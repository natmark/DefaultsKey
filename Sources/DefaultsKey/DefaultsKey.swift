import Foundation

public struct DefaultsKey<T> {
    public var key: String
    public var defaultValue: T

    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

// iOS 12 doesn't support Top-level primitive value encode/decode
// https://forums.swift.org/t/top-level-t-self-encoded-as-number-json-fragment/11001
private struct Container<T: Codable>: Codable {
    let value: T
}

public extension UserDefaults {
    func set<T: Codable>(value: T, forKey: DefaultsKey<T>) {
        let encoder = JSONEncoder()
        if let json = try? encoder.encode(Container(value: value)) {
            set(json, forKey: forKey.key)
        }
    }

    func value<T: Codable>(forKey: DefaultsKey<T>) -> T {
        if !dictionaryRepresentation().keys.contains(forKey.key) {
            return forKey.defaultValue
        } else {
            let decoder = JSONDecoder()
            guard let data = data(forKey: forKey.key), let object = try? decoder.decode(Container<T>.self, from: data) else {
                return forKey.defaultValue
            }
            return object.value
        }
    }
}
