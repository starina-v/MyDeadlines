import UIKit
import Swinject
import SwinjectAutoregistration

enum Route {
    case main
    case addNewTask
    case setDeadlines(TaskModel)
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
        case .addNewTask:
            navigationToAddNewTask()
        case .setDeadlines(let task):
            navigationToSetDeadlines(task: task)
        }
    }
}

// MARK: - Navigate
private extension AppFlow {

    func navigationToMain() {
    }
    
    func navigationToAddNewTask() {
        guard let addNewTaskViewController = resolver.resolve(AddNewTaskViewController.self) else { return  }
        tasksRootViewController.pushViewController(addNewTaskViewController)
    }
    
    func navigationToSetDeadlines(task: TaskModel) {
        guard let setDeadlinesViewController = resolver.resolve(SetDeadlinesViewController.self, argument: task) else { return }
        tasksRootViewController.pushViewController(setDeadlinesViewController)
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
        let tasksViewController = resolver ~> TasksViewController.self
        let newsViewController = resolver ~> MainViewController.self

        tasksRootViewController.setViewControllers([tasksViewController], animated: false)
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

        rootViewController.setViewControllers([tasksRootViewController, newsRootViewController], animated: false)
    }
}
