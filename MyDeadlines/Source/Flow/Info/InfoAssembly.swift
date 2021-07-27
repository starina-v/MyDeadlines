import Rswift
import Swinject
import SwinjectAutoregistration

final class InfoAssembly {}

// MARK: - Assembly
extension InfoAssembly: Assembly {

    func assemble(container: Container) {
        container.register(InfoViewController.self) { resolver in
            let view = R.storyboard.info.instantiateInitialViewController()!
            let presenter = resolver.resolve(InfoPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            return view
        }

        container.register(InfoPresenter.self) { (resolver, view: InfoViewController) in
            let flow = resolver ~> AppFlow.self
            return InfoPresenterImp(view: view, flow: flow)
        }
    }
}
