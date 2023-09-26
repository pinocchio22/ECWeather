//
//  SceneDelegate.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            // guard let _ = (scene as? UIWindowScene) else { return } - 삭제
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.windowScene = windowScene
        
            let tabBarController = UITabBarController()
        
            let firstTab = UINavigationController(rootViewController: WeeklyViewController())
            let secondTab = UINavigationController(rootViewController: RegionalViewController())
            let thirdTab = UINavigationController(rootViewController: MainViewController())
            let forthTab = UINavigationController(rootViewController: AlarmViewController())
            let fifthTab = UINavigationController(rootViewController: SettingViewController())
            
            tabBarController.setViewControllers([firstTab,secondTab,thirdTab,forthTab,fifthTab], animated: true)
        
            if let items = tabBarController.tabBar.items {
                
                items[0].title = "주간"
                items[0].image = UIImage(systemName: "calendar")
                items[0].selectedImage = UIImage(systemName: "calendar")
                items[1].title = "지역별"
                items[1].image = UIImage(systemName: "map")
                items[1].selectedImage = UIImage(systemName: "map.fill")
                items[2].title = "현재"
                items[2].image = UIImage(systemName: "clock")
                items[2].selectedImage = UIImage(systemName: "clock.fill")
                items[3].title = "알람"
                items[3].image = UIImage(systemName: "bell")
                items[3].selectedImage = UIImage(systemName: "bell.badge.fill")
                items[4].title = "설정"
                items[4].image = UIImage(systemName: "gear")
                items[4].selectedImage = UIImage(systemName: "gear")
            }
        
            tabBarController.selectedIndex = 2
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

