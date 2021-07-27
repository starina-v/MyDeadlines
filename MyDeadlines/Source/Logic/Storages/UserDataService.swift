import Foundation

protocol UserDataService: AnyObject {

    var tasks: [TaskModel] { get set }
}

final class UserDataServiceImp {

    private let userDefaultsService: UserDefaultsService

    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
}

// MARK: - UserDataService
extension UserDataServiceImp: UserDataService {

    var tasks: [TaskModel] {
        get {
            userDefaultsService.value(for: .tasks) ?? []
        }
        set {
            userDefaultsService.save(newValue, for: .tasks)
        }
    }
}
