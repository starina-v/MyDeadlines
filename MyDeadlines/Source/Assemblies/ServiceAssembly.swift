import Moya
import Swinject
import SwinjectAutoregistration

final class ServiceAssembly {}

// MARK: - Assembly
extension ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        assembleNetworking(container: container)
        assembleStorages(container: container)
        assembleOther(container: container)
    }
}

// MARK: - Private
private extension ServiceAssembly {
    
    func assembleNetworking(container: Container) {
        container.autoregister(ApiClient.self, initializer: ApiClientImp.init)
        
        container.register(ApiProvider.self) { resolver in
            let plugins: [PluginType] = []
            return MoyaProvider<MultiTarget>(
                endpointClosure: { target in
                    MoyaProvider
                        .defaultEndpointMapping(for: target)
                        .adding(newHTTPHeaderFields: ["Accept": "application/json"])
                },
                plugins: plugins)
        }.inObjectScope(.container)
    }
    
    func assembleStorages(container: Container) {
        container.autoregister(DataManager.self, initializer: DataManagerImp.init).inObjectScope(.container)
        
//        container.register([TaskModel].self) { _ in
//            let tasks: [TaskModel] = []
//            return tasks
//        }
    }
    
    func assembleOther(container: Container) {
    }
}
