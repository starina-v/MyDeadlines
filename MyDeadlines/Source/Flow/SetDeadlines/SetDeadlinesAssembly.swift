import Rswift
import Swinject
import SwinjectAutoregistration

final class SetDeadlinesAssembly {}

// MARK: - Assembly
extension SetDeadlinesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SetDeadlinesViewController.self) { (resolver, task: TaskModel) in
            let view = R.storyboard.setDeadlines.instantiateInitialViewController()!
            let presenter = resolver.resolve(SetDeadlinesPresenter.self, arguments: view, task)!
            view.inject(presenter: presenter)
            return view
        }
        
        container.register(SetDeadlinesPresenter.self) { (resolver, view: SetDeadlinesViewController, task: TaskModel) in
            SetDeadlinesPresenterImp(view: view, task: task)
        }
    }
}
