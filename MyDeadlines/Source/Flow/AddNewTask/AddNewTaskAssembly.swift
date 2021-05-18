import Rswift
import Swinject
import SwinjectAutoregistration

final class AddNewTaskAssembly {}

// MARK: - Assembly
extension AddNewTaskAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AddNewTaskViewController.self) { resolver in
            let view = R.storyboard.addNewTask.instantiateInitialViewController()!
            
            let presenter = resolver.resolve(AddNewTaskPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            
            return view
        }
        
        container.register(AddNewTaskPresenter.self) { (resolver, view: AddNewTaskViewController) in
            let flow = resolver ~> AppFlow.self
            let presenter = AddNewTaskPresenterImp(view: view, flow: flow)
            return presenter
        }
    }
}
