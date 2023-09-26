//
//  ViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    func weatherNowFrame(){
    // Auto layout, variables, and unit scale are not yet supported
    var view = UIView()
    view.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
    view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor

    var parent = self.view!
    parent.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.widthAnchor.constraint(equalToConstant: 345).isActive = true
    view.heightAnchor.constraint(equalToConstant: 59).isActive = true
    view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
    view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 195).isActive = true
    }
    
    
    
    

}

