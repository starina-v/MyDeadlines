import UIKit
import Swinject
import SwinjectAutoregistration

enum Route {
    case main
}

protocol Flow {
    
    var root: UIViewController { get }
    
    func navigate(to route: Route)
}

final class AppFlow {

    private let resolver: Resolver
    private let rootViewController = UINavigationController()

    init(resolver: Resolver) {
        self.resolver = resolver

        setupRootViewController()
        setupGlobalAppearance()
    }
}

// MARK: - Flow
extension AppFlow: Flow {

    var root: UIViewController {
        rootViewController
    }

    func navigate(to step: Route) {
        switch step {
        case .main:
            navigationToMain()
        }
    }
}

// MARK: - Navigate
private extension AppFlow {

    func navigationToMain() {
        let viewController = resolver ~> MainViewController.self
        rootViewController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Appearance
private extension AppFlow {

    func setupGlobalAppearance() {
    }
}

// MARK: - Appearance
private extension AppFlow {

    func setupRootViewController() {
        let viewController = resolver ~> MainViewController.self
        rootViewController.setViewControllers([viewController], animated: false)
    }
}
