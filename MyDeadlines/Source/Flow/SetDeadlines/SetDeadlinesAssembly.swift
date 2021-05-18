import Rswift
import Swinject
import SwinjectAutoregistration

final class SetDeadlinesAssembly {}

// MARK: - Assembly
extension SetDeadlinesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(SetDeadlinesViewController.self) { (resolver, name: String, labs: [LessonModel], practical: [LessonModel]) in
            let view = R.storyboard.setDeadlines.instantiateInitialViewController()!
            let presenter = resolver.resolve(SetDeadlinesPresenter.self, arguments: view, name, labs, practical)!
            view.inject(presenter: presenter)
            return view
        }
        
        container.register(SetDeadlinesPresenter.self) { (resolver, view: SetDeadlinesViewController, name: String, labs: [LessonModel], practical: [LessonModel]) in
            SetDeadlinesPresenterImp(view: view, name: name, labs: labs, practical: practical)
        }
    }
}
