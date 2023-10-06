//
//  BaseTabBarViewController.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/28.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    enum TabBarMenu: Int {
        case Weekly = 0 // 주간
        case Regional // 지역별
        case Main // 오늘
        case Alarm // 알림
        case Setting // 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabControllers()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /**
     @brief TabBarController의 item 이미지 및 컬러 설정
     */
    func setTabControllers() {
        let weeklyVC = WeeklyViewController()
        let regionalVC = RegionalViewController()
        let mainVC = MainViewController()
        let alarmVC = AlarmViewController()
        let settingVC = SettingViewController()
        
        // init tabbar controller
        let controllers = [weeklyVC, regionalVC, mainVC, alarmVC, settingVC]
        self.viewControllers = controllers
        
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
        
        // 주간
        self.tabBar.items![0].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![0].image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        self.tabBar.items![0].selectedImage = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal).withTintColor(.ECWeatherColor3!)
        self.tabBar.items![0].title = "주간"
        
        // 지역별
        self.tabBar.items![1].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![1].image = UIImage(systemName: "map")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        self.tabBar.items![1].selectedImage = UIImage(systemName: "map.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.ECWeatherColor3!)
        self.tabBar.items![1].title = "지역별"
        
        // 오늘
        self.tabBar.items![2].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        if let originalImage = UIImage(named: "AppLogo") {
            let newSize = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            originalImage.draw(in: CGRect(origin: .zero, size: newSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal).withTintColor(.ECWeatherColor3!)
            UIGraphicsEndImageContext()
            let resizedImageBW = resizedImage?.withRenderingMode(.alwaysTemplate).withTintColor(.gray)
            self.tabBar.items![2].image = resizedImageBW
            self.tabBar.items![2].selectedImage = resizedImage
        }
        self.tabBar.items![2].title = "오늘"
        
        // 알림
        self.tabBar.items![3].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![3].image = UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        self.tabBar.items![3].selectedImage = UIImage(systemName: "bell.badge.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.ECWeatherColor3!)
        self.tabBar.items![3].title = "알림"
        
        // 설정
        self.tabBar.items![4].imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        self.tabBar.items![4].image = UIImage(systemName: "gear.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        self.tabBar.items![4].selectedImage = UIImage(systemName: "gear.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.ECWeatherColor3!)
        self.tabBar.items![4].title = "설정"
    }
    
    /**
     @brief TabBarController에서 입력받은 index로 이동
     
     @param TabBarController에서 이동하고자 하는 index
     */
    func moveToTabBarIndex(index: TabBarMenu) {
        SceneDelegate.applicationDelegate().tabBarController!.selectedIndex = index.rawValue
    }
    
    /**
     @brief TabBarController에 현재 선택되어진 index를 리턴
     */
    func selectedTabBarIndex() -> TabBarMenu {
        return TabBarMenu(rawValue: SceneDelegate.applicationDelegate().tabBarController!.selectedIndex) ?? TabBarMenu.Main
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension BaseTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            // do your stuff
        }
        print("tabBarIndex : \(tabBarIndex)")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let currentIndex = tabBarController.selectedIndex
        print("currentIndex : \(currentIndex)")
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
