import UIKit
import Swinject
import SwinjectAutoregistration

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var assembler: Assembler!

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
         
        configureDependencies()
        configureFlow()
    }
}

// MARK: - Configure
private extension SceneDelegate {
    
    func configureDependencies() {
        let serviceAssembler = Assembler([ServiceAssembly()])
        
        let modulesAssembler = Assembler(
            [
                MainAssembly(),
                TasksAssembly(),
                CreateTaskAssembly(),
                TaskInfoAssembly()
            ],
            parent: serviceAssembler)
        
        assembler = Assembler(
            [FlowAssembly()],
            parent: modulesAssembler)
    }
    
    func configureFlow() {
        let appFlow = assembler.resolver ~> AppFlow.self
        appFlow.setup()
        
        self.window?.rootViewController = appFlow.root
        self.window?.makeKeyAndVisible()
    }
}
