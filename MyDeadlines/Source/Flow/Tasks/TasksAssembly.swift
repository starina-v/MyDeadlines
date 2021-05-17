//
//  TasksAssymbly.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 11.05.2021.
//

import Rswift
import Swinject
import SwinjectAutoregistration

final class TasksAssembly {}

// MARK: - Assembly
extension TasksAssembly: Assembly {

    func assemble(container: Container) {
        container.register(TasksViewController.self) { resolver in
            let view = R.storyboard.tasks.instantiateInitialViewController()!

            let presenter = resolver.resolve(TasksPresenterImp.self, argument: view)!
            view.inject(presenter: presenter)

            return view
        }

        container.register(TasksPresenterImp.self) { (resolver, view: TasksViewController) in
            TasksPresenterImp(view: view)
        }.initCompleted { resolver, presenter in
            presenter.inject(flow: resolver ~> AppFlow.self)
        }
    }
}
