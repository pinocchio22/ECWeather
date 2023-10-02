//
//  IntroViewController.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/28.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SceneDelegate.applicationDelegate().changeInitViewController()
        }
    }
    

}
