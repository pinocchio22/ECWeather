//
//  ProfilePageVC.swift
//  SpartaToDoList
//
//  Created by t2023-m0064 on 2023/09/20.
//

import Foundation
import UIKit




class ProfilePageViewController : UIViewController{

    
    // Auto layout, variables, and unit scale are not yet supported
    func mainTitl(){
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 97, height: 25)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "Helvetica-Bold", size: 18)
        // Line height: 24.51 pt
        // (identical to box height)
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "nabaecamp", attributes: [NSAttributedString.Key.kern: -1])
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 97).isActive = true
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 139).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 54).isActive = true
    }
    
    
    func spartaimage(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 88, height: 88)
        let image0 = UIImage(named: "spartan_image.png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 88).isActive = true
        view.heightAnchor.constraint(equalToConstant: 88).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 14).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 93).isActive = true
    }
    
    
    
    func number1(){
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 22)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "OpenSans-Bold", size: 16.5)
        // Line height: 22.47 pt
        view.textAlignment = .center
        view.text = "7"
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.heightAnchor.constraint(equalToConstant: 22).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 152).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 116).isActive = true
    }
    
    
    
    
    func number2(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 22)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "OpenSans-Bold", size: 16.5)
        // Line height: 22.47 pt
        view.textAlignment = .center
        view.text = "0"

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.heightAnchor.constraint(equalToConstant: 22).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 232).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 116).isActive = true
    }
    
    
    
    func number3(){
        // Auto layout, variables, and unit scale are not yet supported
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 22)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "OpenSans-Bold", size: 16.5)
        // Line height: 22.47 pt
        view.textAlignment = .center
        view.text = "0"

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.heightAnchor.constraint(equalToConstant: 22).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 314).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 116).isActive = true
    }
    
    
    
    func text1(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 28, height: 19)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "OpenSans-Regular", size: 14)
        // Line height: 19.07 pt
        // (identical to box height)
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "post", attributes: [NSAttributedString.Key.kern: -0.3])

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 35).isActive = true
        view.heightAnchor.constraint(equalToConstant: 19).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 143).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 138).isActive = true
    }
    
    
    
    func text2(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 51, height: 19)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "OpenSans-Regular", size: 14)
        // Line height: 19.07 pt
        // (identical to box height)
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "follower", attributes: [NSAttributedString.Key.kern: -0.3])

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 70).isActive = true
        view.heightAnchor.constraint(equalToConstant: 19).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 213).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 138).isActive = true
    }
    
    
    
    func text3(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 57, height: 19)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "OpenSans-Regular", size: 14)
        // Line height: 19.07 pt
        // (identical to box height)
        view.textAlignment = .center
        view.attributedText = NSMutableAttributedString(string: "following", attributes: [NSAttributedString.Key.kern: -0.3])

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 70).isActive = true
        view.heightAnchor.constraint(equalToConstant: 19).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 290).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 138).isActive = true
    }
    
    
    func menu (){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 21, height: 17.5)
        let image0 = UIImage(named: "Menu.png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 21).isActive = true
        view.heightAnchor.constraint(equalToConstant: 17.5).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 338).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 58).isActive = true
        
    }
    
    
    
    func name(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 38, height: 19)
        view.textColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
        view.font = UIFont(name: "OpenSans-Bold", size: 14)
        // Line height: 19.07 pt
        // (identical to box height)
        view.attributedText = NSMutableAttributedString(string: "르탄이", attributes: [NSAttributedString.Key.kern: -0.5])

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 19).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 195).isActive = true
    }
    
    
    
    
    func under(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 345, height: 19)
        view.textColor = UIColor(red: 0.145, green: 0.145, blue: 0.145, alpha: 1)
        view.font = UIFont(name: "OpenSans-Regular", size: 14)
        // Line height: 19.07 pt
        // (identical to box height)
        view.attributedText = NSMutableAttributedString(string: "iOS Developer 🍎", attributes: [NSAttributedString.Key.kern: -0.5])

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 345).isActive = true
        view.heightAnchor.constraint(equalToConstant: 19).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 216).isActive = true
    }
    
    
    
    func under2(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 121, height: 19)
        view.textColor = UIColor(red: 0.061, green: 0.274, blue: 0.492, alpha: 1)
        view.font = UIFont(name: "OpenSans-Regular", size: 14)
        // Line height: 19.07 pt
        // (identical to box height)
        view.attributedText = NSMutableAttributedString(string: "spartacodingclub.kr", attributes: [NSAttributedString.Key.kern: -0.5])

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.heightAnchor.constraint(equalToConstant: 19).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 235).isActive = true
    }
    

    
    
    
    func button1(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        view.layer.backgroundColor = UIColor(red: 0.22, green: 0.596, blue: 0.953, alpha: 1).cgColor
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "OpenSans-Bold", size: 14)
        view.textAlignment = .center
        view.text = "Follow"
        view.layer.cornerRadius = 4

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 265).isActive = true
    }
    
    
    
    func button2(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        view.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "OpenSans-Bold", size: 14)
        view.textAlignment = .center
        view.text = "Follow"
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 173).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 265).isActive = true
    }
    
    
    func button3(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let image0 = UIImage(named: "More.png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 330).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 265).isActive = true
    }
    
    

    
    
    func poto(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIButton()
        view.frame = CGRect(x: 0, y: 0, width: 22.5, height: 22.5)
        let image0 = UIImage(named: "Grid.png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)

        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 22.5).isActive = true
        view.heightAnchor.constraint(equalToConstant: 22.5).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 52).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 315).isActive = true
    }
    
    
    
    
    
    func views(){
        mainTitl()
        spartaimage()
        number1()
        number2()
        number3()
        text1()
        text2()
        text3()
        menu ()
        name()
        under()
        under2()
        button1()
        button2()
        button3()
        poto()
        dummyImage1()
        dummyImage2()
        dummyImage3()
        dummyImage4()
        dummyImage5()
        dummyImage6()
        dummyImage7()
    }
    

    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        views()
        
    }
}





extension ProfilePageViewController{
    
    func dummyImage1(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 124, height: 124)
        let image0 = UIImage(named: "picture (1).png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 124).isActive = true
        view.heightAnchor.constraint(equalToConstant: 124).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 350).isActive = true
    }
    
    
    func dummyImage2(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 124, height: 124)
        let image0 = UIImage(named: "picture.png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 124).isActive = true
        view.heightAnchor.constraint(equalToConstant: 124).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 126).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 350).isActive = true
    }
    
    func dummyImage3(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 124, height: 124)
        let image0 = UIImage(named: "picture (3).png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 124).isActive = true
        view.heightAnchor.constraint(equalToConstant: 124).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 252).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 350).isActive = true
    }
    
    func dummyImage4(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 124, height: 124)
        let image0 = UIImage(named: "picture (4).png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.25, b: 0, c: 0, d: 1, tx: -0.12, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 124).isActive = true
        view.heightAnchor.constraint(equalToConstant: 124).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 476).isActive = true
    }
    
    func dummyImage5(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 124, height: 124)
        let image0 = UIImage(named: "picture (5).png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.02, b: 0, c: 0, d: 1, tx: -0.01, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 124).isActive = true
        view.heightAnchor.constraint(equalToConstant: 124).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 126).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 476).isActive = true
    }
    
    func dummyImage6(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 124, height: 124)
        let image0 = UIImage(named: "picture (6).png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 124).isActive = true
        view.heightAnchor.constraint(equalToConstant: 124).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 252).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 476).isActive = true
    }
    
    func dummyImage7(){
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 124, height: 124)
        let image0 = UIImage(named: "picture (7).png")?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 124).isActive = true
        view.heightAnchor.constraint(equalToConstant: 124).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 602).isActive = true
    }
    
    
}











class CollectionView : UICollectionView{
    
    static let CV = CollectionView()
    
//    CV.leadingAnchor.constraint(equalTo: parent)
    
}


