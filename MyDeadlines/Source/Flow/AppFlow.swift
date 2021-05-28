import UIKit
import Swinject
import SwinjectAutoregistration
import SafariServices

enum Route {
    case main
    case safari(String)
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
        case .safari(let link):
            navigationToSafari(with: link)
        }
    }
}

// MARK: - Navigate
private extension AppFlow {

    func navigationToMain() {
    }
    
    func navigationToSafari(with link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = false

            let safari = SFSafariViewController(url: url, configuration: config)
            safari.preferredBarTintColor = R.color.primary()
            safari.preferredControlTintColor = .white

            rootViewController.present(safari, animated: true)
        }
    }
}

// MARK: - Appearance
private extension AppFlow {

    func setupGlobalAppearance() {        
        rootViewController.tabBar.isTranslucent = false
        rootViewController.tabBar.updateColors(
            with: .init(
                background: R.color.primary(),
                selectedBackground: nil,
                item: .lightGray,
                selectedItem: .white))
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = R.color.primary()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
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
            image: R.image.list(),
            selectedImage: nil)

        let newsTabBarItem = UITabBarItem(
            title: "News",
            image: R.image.news(),
            selectedImage: nil)
        
        tasksViewController.tabBarItem = tasksTabBarItem
        newsViewController.tabBarItem = newsTabBarItem

        rootViewController.setViewControllers([tasksRoorViewController, newsRootViewController], animated: false)
    }
}
