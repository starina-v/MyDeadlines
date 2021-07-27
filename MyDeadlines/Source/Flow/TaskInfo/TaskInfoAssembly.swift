import Rswift
import Swinject
import SwinjectAutoregistration

final class TaskInfoAssembly {}

// MARK: - Assembly
extension TaskInfoAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(TaskInfoViewController.self) { (resolver, task: TaskModel, index: Int) in
            let view = R.storyboard.taskInfo.instantiateInitialViewController()!
            let presenter = resolver.resolve(TaskInfoPresenter.self, arguments: view, task, index)!
            view.inject(presenter: presenter)
            return view
        }
        
        container.register(TaskInfoPresenter.self) { (resolver, view: TaskInfoViewController, task: TaskModel, index: Int) in
            let flow = resolver ~> AppFlow.self
            let presenter = TaskInfoPresenterImp(view: view, flow: flow, dataManager: resolver~>, task: task, index: index)
            return presenter
        }
    }
}
