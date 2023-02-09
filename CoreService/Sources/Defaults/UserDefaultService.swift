import Foundation

public class UserDefaultService {

    let userDefault = UserDefaults.standard

    public init() { }

    public func save<T: Decodable>(_ value: T, for keyPath: KeyPath<DefaultKeys, DefaultKey<T>>) {
        do {
            let key = DefaultKeys.main[keyPath: keyPath]
            let data = try JSONEncoder().encode(value)
            userDefault.set(data, forKey: key.identifier)
            userDefault.synchronize()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    public func fetch<T: Decodable>(for keyPath: KeyPath<DefaultKeys, DefaultKey<T>>) -> T {
        let key = DefaultKeys.main[keyPath: keyPath]
        guard let data = userDefault.data(forKey: key.identifier), let value = try? JSONDecoder().decode(key.type, from: data) else { return key.defaultValue }
        return value
    }
}
