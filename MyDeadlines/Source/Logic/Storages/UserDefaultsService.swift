import Foundation

enum UserDefaultsKey {
    case tasks

    var stringValue: String {
        switch self {
        case .tasks:
            return "tasks"
        }
    }
}

protocol UserDefaultsService {

    func save<Value: Codable>(_ value: Value, for key: UserDefaultsKey)

    func save<Value: Codable>(_ value: Value?, for key: UserDefaultsKey)

    func value<Value: Codable>(for key: UserDefaultsKey) -> Value?

    func removeValue(for key: UserDefaultsKey)
}

final class UserDefaultsServiceImp {

    private let defaults = UserDefaults.standard
}

// MARK: - UserDefaultsService
extension UserDefaultsServiceImp: UserDefaultsService {

    func save<Value: Codable>(_ value: Value, for key: UserDefaultsKey) {
        defaults.set(object: value, forKey: key.stringValue)
    }

    func save<Value: Codable>(_ value: Value?, for key: UserDefaultsKey) {
        if let value = value {
            save(value, for: key)
        } else {
            removeValue(for: key)
        }
    }

    func value<Value: Codable>(for key: UserDefaultsKey) -> Value? {
        defaults.object(Value.self, with: key.stringValue)
    }

    func removeValue(for key: UserDefaultsKey) {
        defaults.removeObject(forKey: key.stringValue)
    }
}
