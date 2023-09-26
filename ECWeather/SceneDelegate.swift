//
//  SceneDelegate.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    /**
     @brief  navigationBarController 객체
     */
    var navigationController : UINavigationController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // guard let _ = (scene as? UIWindowScene) else { return } - 삭제
        guard let windowScene = (scene as? UIWindowScene) else { return }
        navigationController = UINavigationController(rootViewController: MainViewController())
        //네비게이션바 히든
        navigationController?.isNavigationBarHidden = true;
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
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

    /**
     @brief navigationController의 쌓여있는 스택을 리턴
     */
    static func navigationViewControllers() -> [UIViewController]{
        return SceneDelegate.applicationDelegate().navigationController!.viewControllers
    }
    /**
     @brief Appdelegate의 객체를 리턴
     */
    static var realDelegate: SceneDelegate?;
    static func applicationDelegate() -> SceneDelegate{
        if Thread.isMainThread{
            return UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate;
        }
        let dg = DispatchGroup()
        dg.enter()
        DispatchQueue.main.async{
            realDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate;
            dg.leave();
        }
        dg.wait();
        return realDelegate!
    }
}

