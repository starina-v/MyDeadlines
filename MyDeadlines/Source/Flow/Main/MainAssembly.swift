import Rswift
import Swinject
import SwinjectAutoregistration

final class MainAssembly {}

// MARK: - Assembly
extension MainAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MainViewController.self) { resolver in
            let view = R.storyboard.main.instantiateInitialViewController()!

            let presenter = resolver.resolve(MainPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            
            return view
        }

        container.register(MainPresenter.self) { (resolver, view: MainViewController) in
            MainPresenterImp(view: view, apiClient: resolver~>)
        }
    }
}
