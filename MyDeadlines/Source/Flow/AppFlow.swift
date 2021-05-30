import UIKit
import Swinject
import SwinjectAutoregistration
import SafariServices

enum Route {
    case main
    case createTask
    case taskInfo(TaskModel, Int)
    case tasks
    case safari(String)
}

protocol Flow: AnyObject {
    
    var root: UIViewController { get }
    
    func navigate(to route: Route)
}

final class AppFlow {

    private let resolver: Resolver
    private let rootViewController = UITabBarController()
    private let tasksRootViewController = UINavigationController()
    private let newsRootViewController = UINavigationController()

    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func setup() {
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
        case .createTask:
            navigationToCreateTask()
        case .taskInfo(let task, let index):
            navigationToTaskInfo(task: task, index: index)
        case .tasks:
            navigationToTasks()
        case .safari(let link):
            navigationToSafari(with: link)
        }
    }
}

// MARK: - Navigate
private extension AppFlow {

    func navigationToMain() {
    }
    
    func navigationToCreateTask() {
        let createTaskViewController = resolver ~> CreateTaskViewController.self
        tasksRootViewController.pushViewController(createTaskViewController)
    }
    
    func navigationToTaskInfo(task: TaskModel, index: Int) {
        guard let taskInfoViewController = resolver.resolve(TaskInfoViewController.self, arguments: task, index) else { return }
        tasksRootViewController.pushViewController(taskInfoViewController)
    }
    
    func navigationToTasks() {
        tasksRootViewController.popViewController()
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
        let tasksViewController = resolver ~> TasksViewController.self
        let newsViewController = resolver ~> MainViewController.self

        tasksRootViewController.setViewControllers([tasksViewController], animated: false)
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

        rootViewController.setViewControllers([tasksRootViewController, newsRootViewController], animated: false)
    }
}
