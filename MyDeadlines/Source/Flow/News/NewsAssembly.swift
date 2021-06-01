import Rswift
import Swinject
import SwinjectAutoregistration

final class NewsAssembly {}

// MARK: - Assembly
extension NewsAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NewsViewController.self) { resolver in
            let view = R.storyboard.news.instantiateInitialViewController()!
            let presenter = resolver.resolve(NewsPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            return view
        }

        container.register(NewsPresenter.self) { (resolver, view: NewsViewController) in
            let flow = resolver ~> AppFlow.self
            return NewsPresenterImp(view: view, flow: flow, apiClient: resolver~>)
        }
    }
}
