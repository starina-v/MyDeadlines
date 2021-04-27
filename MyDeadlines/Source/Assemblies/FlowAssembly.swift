import Swinject
import SwinjectAutoregistration

final class FlowAssembly {}

// MARK: - Assembly
extension FlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AppFlow.self) { (resolver) in
            AppFlow(resolver: resolver)
        }.inObjectScope(.container)
    }
}
