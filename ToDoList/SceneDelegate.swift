//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Анатолий Лушников on 03.09.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        let assemblyMainModule = AssemblyMainModule()
        let coordinator = MainModuleCoordinator(navigationController: navigationController, mainModuleAssembly: assemblyMainModule)
        coordinator.start()
//        let assembly = AssemblyMainModule()
//        window = UIWindow(windowScene: scene)
//        window?.rootViewController = assembly.build()
//        window?.makeKeyAndVisible() 
    }
}

