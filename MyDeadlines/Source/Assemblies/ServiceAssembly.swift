//
//  ServiceAssembly.swift
//  MyDeadlines
//
//  Created by Vlad Starina on 24.04.2021.
//

import Swinject
import SwinjectAutoregistration

final class ServiceAssembly {}

// MARK: - Assembly
extension ServiceAssembly: Assembly {

    func assemble(container: Container) {
        assembleNetworking(container: container)
        assembleStorages(container: container)
        assembleOther(container: container)
    }
}

// MARK: - Private
private extension ServiceAssembly {

    func assembleNetworking(container: Container) {
    }

    func assembleStorages(container: Container) {
//        container.autoregister(CoreDataService.self, initializer: CoreDataServiceImp.init)
//            .inObjectScope(.container)
    }

    func assembleOther(container: Container) {
    }
}
