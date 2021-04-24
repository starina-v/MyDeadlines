//
//  FlowAssembly.swift
//  MyDeadlines
//
//  Created by Vlad Starina on 24.04.2021.
//

import Swinject
import SwinjectAutoregistration

final class FlowAssembly {}

// MARK: - Assembly
extension FlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AppFlow.self) { (resolver) in
            AppFlow(resolver: resolver)
        }
    }
}
