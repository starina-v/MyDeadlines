//
//  AppDelegate.swift
//  MyDeadlines
//
//  Created by Vlad Starina on 24.04.2021.
//

import UIKit
import Swinject
import SwinjectAutoregistration

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var assembler: Assembler!

    public lazy var window: UIWindow? = {
        let window = UIWindow()
        window.makeKeyAndVisible()
        return window
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureDependencies()
        configureFlow()
        
        return true
    }
}

// MARK: - Configure
private extension AppDelegate {

    func configureDependencies() {
        let serviceAssembler = Assembler([ServiceAssembly()])

        let modulesAssembler = Assembler(
            [
                MainAssembly()
            ],
            parent: serviceAssembler)

        assembler = Assembler(
            [FlowAssembly()],
            parent: modulesAssembler)
    }

    func configureFlow() {
        let appFlow = assembler.resolver ~> AppFlow.self

        self.window?.rootViewController = appFlow.root
        self.window?.makeKeyAndVisible()
    }
}
