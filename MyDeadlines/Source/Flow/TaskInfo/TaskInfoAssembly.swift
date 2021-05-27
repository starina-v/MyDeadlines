import Rswift
import Swinject
import SwinjectAutoregistration

final class TaskInfoAssembly {}

// MARK: - Assembly
extension TaskInfoAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(TaskInfoViewController.self) { resolver in
            let view = R.storyboard.taskInfo.instantiateInitialViewController()!
            let presenter = resolver.resolve(TaskInfoPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            return view
        }
        
        container.register(TaskInfoPresenter.self) { (resolver, view: TaskInfoViewController) in
            let flow = resolver ~> AppFlow.self
            let presenter = TaskInfoPresenterImp(view: view, flow: flow)
            return presenter
        }
    }
}
