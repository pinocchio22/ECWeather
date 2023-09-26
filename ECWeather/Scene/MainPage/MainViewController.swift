//
//  ViewController.swift
//  testForWeatherProject(team)
//
//  Created by t2023-m0064 on 2023/09/26.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - weatherNowView
    
    func weatherNowFramePart() {
        weatherNowFrame()
        localWeather()
        weatherImage()
        nowTemperature()
        weatherName()
        dailyTemperature()
    }
    
    func weatherNowFrame() {
        // Auto layout, variables, and unit scale are not yet supported
        var nowFrameView = UIView()
        nowFrameView.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        nowFrameView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
//        nowFrameView.layer.borderWidth = 5
//        nowFrameView.layer.borderColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00).cgColor

        var parent = self.view!
        parent.addSubview(nowFrameView)
        nowFrameView.translatesAutoresizingMaskIntoConstraints = false
        nowFrameView.widthAnchor.constraint(equalToConstant: 330).isActive = true
        nowFrameView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        nowFrameView.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        nowFrameView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 105).isActive = true
        nowFrameView.layer.cornerRadius = 15
    }

    // 날씨 클래스, 지역명
    func localWeather() {
        let localLabel = UILabel()
        localLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        localLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        localLabel.font = UIFont(name: "Helvetica-Bold", size: 25)
        // Line height: 22.47 pt
        localLabel.textAlignment = .center
        localLabel.text = "지역명"
        
        let parent = self.view!
        parent.addSubview(localLabel)
        localLabel.translatesAutoresizingMaskIntoConstraints = false
        localLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        localLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        localLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        localLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 116).isActive = true
    }
    
    // 날씨 클래스, 날씨 - 이미지
    func weatherImage() {
        var imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let weatherImage = UIImage(named: "More.png")?.cgImage
        let weatherLayer = CALayer()
        weatherLayer.contents = weatherImage
        weatherLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        weatherLayer.bounds = view.bounds
        weatherLayer.position = view.center
        imageView.layer.addSublayer(weatherLayer)

        let parent = self.view!
        parent.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 200).isActive = true
    }
    
    // 날씨 클래스, 온도
    func nowTemperature() {
        let temperatuerLabel = UILabel()
        temperatuerLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 32)
        temperatuerLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        temperatuerLabel.font = UIFont(name: "Helvetica-Bold", size: 25)
        temperatuerLabel.textAlignment = .center
        temperatuerLabel.text = "온도"
        
        let parent = self.view!
        parent.addSubview(temperatuerLabel)
        temperatuerLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatuerLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        temperatuerLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        temperatuerLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        temperatuerLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 300).isActive = true
    }
    
    // 날씨클래스, 날씨 - 날씨명
    func weatherName() {
        let weatherNameLabel = UILabel()
        weatherNameLabel.frame = CGRect(x: 0, y: 0, width: 10, height: 22)
        weatherNameLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        weatherNameLabel.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        // Line height: 22.47 pt
        weatherNameLabel.textAlignment = .center
        weatherNameLabel.text = "날씨명"
        
        let parent = self.view!
        parent.addSubview(weatherNameLabel)
        weatherNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherNameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weatherNameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
//        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
//        view.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        weatherNameLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        weatherNameLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 335).isActive = true
    }
    
    // 최고 온도 / 최저 온도
    func dailyTemperature() {
        let dtLabel = UILabel()
        dtLabel.frame = CGRect(x: 0, y: 0, width: 210, height: 22)
        dtLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        dtLabel.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        // Line height: 22.47 pt
        dtLabel.textAlignment = .center
        dtLabel.text = "최고 온도 / 최저 온도"
        
        let parent = self.view!
        parent.addSubview(dtLabel)
        dtLabel.translatesAutoresizingMaskIntoConstraints = false
        dtLabel.widthAnchor.constraint(equalToConstant: 210).isActive = true
        dtLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        dtLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        dtLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 360).isActive = true
    }
    
    // MARK: - weatherTodayView
    
    func weatherTodayPart() {
        weatherTodayFrame()
        weatherMent()
    }
    
    func weatherTodayFrame() {
        // Auto layout, variables, and unit scale are not yet supported
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        view.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
//        view.layer.borderWidth = 5
//        view.layer.borderColor = UIColor(red: 0.0, green: 0, blue: 0, alpha: 0).cgColor

        var parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 330).isActive = true
        view.heightAnchor.constraint(equalToConstant: 110).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 30).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 427).isActive = true
        view.layer.cornerRadius = 15
    }
    
    // 날씨 멘트
    func weatherMent() {
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 210, height: 22)
        view.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        view.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        // Line height: 22.47 pt
        view.textAlignment = .center
        view.text = "날씨멘트..."
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 210).isActive = true
        view.heightAnchor.constraint(equalToConstant: 22).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 5).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 435).isActive = true
    }
        
    // 날씨 콜렉션뷰, 시간별 날씨 이미지, 온도
    
    // MARK: - RestWeatherInfoViews
    
    func weatherNowFrame3() {
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        view.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
//        view.layer.borderWidth = 5
//        view.layer.borderColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00).cgColor


        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 330).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 30).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 560).isActive = true
        view.layer.cornerRadius = 15
    }
    
    func weatherNowFrame4() {
        // Auto layout, variables, and unit scale are not yet supported
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        view.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
//        view.layer.borderWidth = 5
//        view.layer.borderColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00).cgColor


        var parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 330).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 30).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 640).isActive = true
        view.layer.cornerRadius = 15
    }
    
    func weatherNowView() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        weatherNowFramePart()
        weatherTodayPart()
        weatherNowFrame3()
        weatherNowFrame4()
    }
}


