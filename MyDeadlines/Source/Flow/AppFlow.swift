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
    private let rootViewController = UITabBarController()
    private let tasksRoorViewController = UINavigationController()
    private let newsRootViewController = UINavigationController()

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
        let tasksViewController = UIViewController()
        let newsViewController = resolver ~> MainViewController.self

        tasksRoorViewController.setViewControllers([tasksViewController], animated: false)
        newsRootViewController.setViewControllers([newsViewController], animated: false)
        
        let tasksTabBarItem = UITabBarItem(
            title: "Tasks",
            image: .add,
            selectedImage: nil)

        let newsTabBarItem = UITabBarItem(
            title: "News",
            image: .strokedCheckmark,
            selectedImage: nil)
        
        tasksViewController.tabBarItem = tasksTabBarItem
        newsViewController.tabBarItem = newsTabBarItem

        rootViewController.setViewControllers([tasksRoorViewController, newsRootViewController], animated: false)
    }
}
