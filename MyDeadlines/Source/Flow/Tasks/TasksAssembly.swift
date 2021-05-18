import Rswift
import Swinject
import SwinjectAutoregistration

final class TasksAssembly {}

// MARK: - Assembly
extension TasksAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(TasksViewController.self) { resolver in
            let view = R.storyboard.tasks.instantiateInitialViewController()!
            
            let presenter = resolver.resolve(TasksPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            
            return view
        }
        
        container.register(TasksPresenter.self) { (resolver, view: TasksViewController) in
            let flow = resolver ~> AppFlow.self
            let presenter = TasksPresenterImp(view: view, flow: flow)
            return presenter
        }
    }
}
