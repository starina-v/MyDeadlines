//
//  SetDeadlinesAssembly.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 30.04.2021.
//

import Rswift
import Swinject
import SwinjectAutoregistration

final class SetDeadlinesAssembly {}

// MARK: - Assembly
extension SetDeadlinesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SetDeadlinesViewController.self) { resolver in
            let view = R.storyboard.setDeadlines.instantiateInitialViewController()!

            let presenter = resolver.resolve(SetDeadlinesPresenter.self, argument: view)!
            view.inject(presenter: presenter)

            return view
        }

        container.register(SetDeadlinesPresenter.self) { (resolver, view: SetDeadlinesViewController) in
            SetDeadlinesPresenterImp(view: view)
        }
    }
}
