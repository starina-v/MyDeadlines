import Rswift
import Swinject
import SwinjectAutoregistration

final class CreateTaskAssembly {}

// MARK: - Assembly
extension CreateTaskAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CreateTaskViewController.self) { resolver in
            let view = R.storyboard.createTask.instantiateInitialViewController()!
            let presenter = resolver.resolve(CreateTaskPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            return view
        }
        
        container.register(CreateTaskPresenter.self) { (resolver, view: CreateTaskViewController) in
            let flow = resolver ~> AppFlow.self
            let presenter = CreateTaskPresenterImp(view: view, flow: flow)
            return presenter
        }
    }
}
