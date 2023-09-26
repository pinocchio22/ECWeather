//
//  BaseViewController.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/26.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //gesture의 이벤트가 끝나도 뒤에 이벤트를 View로 전달
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // 화면에 터치 했을 때 키보드 사라짐
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /**
     @brief 네비게이션 이동
     
     @param viewController - 이동하려는 viewController
     
     @param animated - 애니메이션 여부
     
     @param duration - 네비게이션 이동 duration
     
     @param transitionType - 네비게이션 이동 transition type
     */
    func navigationPushController(viewController : UIViewController, animated : Bool, duration : Double = 0.3, transitionType : (CATransitionType, CATransitionSubtype) = (.push, .fromRight))
    {
        let array = SceneDelegate.navigationViewControllers()
        if  array.count > 0
        {
            Util.print(output: "navigationStack : \(array.count)")
            
            //navigation 커스터마이징
            let transition = CATransition.init()
            transition.duration = duration
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            transition.type = transitionType.0  //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
            transition.subtype = transitionType.1 //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
            SceneDelegate.applicationDelegate().navigationController?.view.layer.add(transition, forKey: nil)
            SceneDelegate.applicationDelegate().navigationController?.pushViewController(viewController, animated: animated)
        }
    }
}
