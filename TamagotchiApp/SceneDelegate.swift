//
//  SceneDelegate.swift
//  TamagotchiApp
//
//  Created by 한성봉 on 2023/08/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let isSelected = UserDefaultsHelper.shared.isSelected
        
        if !isSelected {
            let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
            
            guard let vc = sb.instantiateViewController(
                withIdentifier: MainViewController.identifier
            ) as? MainViewController else { return }
            
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        } else {
            let sb = UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
            
            guard let vc = sb.instantiateViewController(
                withIdentifier: DetailViewController.identifier
            ) as? DetailViewController else { return }
            
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        }
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
        
        // 아이콘 Badge 알림 개수 초기화
        UIApplication.shared.applicationIconBadgeNumber = 300
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
        configureUserNotification()
        
    }


}

extension SceneDelegate {
    func configureUserNotification() {
        let name = UserDefaultsHelper.shared.name
        let level = UserDefaultsHelper.shared.level
        
        let content = UNMutableNotificationContent()
        content.title = "\(name)가 배고파하고 있어요 돌아와서 먹이를 주세요ㅠ"
        content.body = "레벨은 \(level)이에요.~~"
        content.badge = 333
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
}
