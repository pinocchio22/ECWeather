//
//  ViewController.swift
//  testForWeatherProject(team)
//
//  Created by t2023-m0064 on 2023/09/26.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    let cellIdentifier = "WeatherCell"
    let numberOfHours = 24
    
    var scrollView = UIScrollView()
    
    let mainPageTitle = UILabel()
    let currentWeatherFrameTopLine = UIView()
    let currentWeatherFrameBottomLine = UIView()
    let currentWeatherViewFrame = UIView()
    var locationOfCurrentWeather = UILabel()
    var currentWeatherImage = UIImageView()
    var currentTemperatuerLabel = UILabel()
    var currentWeatherLabel = UILabel()
    var dailyTemperatuerLabel = UILabel()
    let hourlyWeatherFrameTopLine = UIView()
    let hourlyWeatherFrameBottomLine = UIView()
    let hourlyWeatherViewFrame = UIView()
    var dailyWeatherMentRabel = UILabel()
    let otherWeatherInfoFrameView = UIView()
    let otherWeatherInfoFrameview2 = UIView()
    let UnderLineOfDailyWeatherMent = UIView()
    let nameOfWeatherInfoFrameView = UILabel()
    let nameOfWeatherInfoFrameView2 = UILabel()
    let otherWeatherInfoFrameTopLine = UIView()
    let otherWeatherInfoFrameBottomLine = UIView()
    let otherWeatherInfoFrame2TopLine = UIView()
    let otherWeatherInfoFrame2BottomLine = UIView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor(red: 0, green: 0.0, blue: 0.0, alpha: 0.0)
        return collectionView
    }()
    
    
    let contentView = UIView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configure()
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        contentView.addSubview(mainPageTitle)
        
        contentView.addSubview(currentWeatherViewFrame)
        currentWeatherViewFrame.addSubview(currentWeatherFrameTopLine)
        currentWeatherViewFrame.addSubview(currentWeatherFrameBottomLine)
        currentWeatherViewFrame.addSubview(locationOfCurrentWeather)
        currentWeatherViewFrame.addSubview(currentWeatherImage)
        currentWeatherViewFrame.addSubview(currentTemperatuerLabel)
        currentWeatherViewFrame.addSubview(currentWeatherLabel)
        currentWeatherViewFrame.addSubview(dailyTemperatuerLabel)
        
        contentView.addSubview(hourlyWeatherViewFrame)
        hourlyWeatherViewFrame.addSubview(hourlyWeatherFrameTopLine)
        hourlyWeatherViewFrame.addSubview(dailyWeatherMentRabel)
        hourlyWeatherViewFrame.addSubview(UnderLineOfDailyWeatherMent)
        hourlyWeatherViewFrame.addSubview(hourlyWeatherFrameBottomLine)
        
        contentView.addSubview(otherWeatherInfoFrameView)
        otherWeatherInfoFrameView.addSubview(otherWeatherInfoFrameTopLine)
        otherWeatherInfoFrameView.addSubview(nameOfWeatherInfoFrameView)
        otherWeatherInfoFrameView.addSubview(otherWeatherInfoFrameBottomLine)
        
        contentView.addSubview(otherWeatherInfoFrameview2)
        otherWeatherInfoFrameview2.addSubview(otherWeatherInfoFrame2TopLine)
        otherWeatherInfoFrameview2.addSubview(nameOfWeatherInfoFrameView2)
        otherWeatherInfoFrameview2.addSubview(otherWeatherInfoFrame2BottomLine)
        
        hourlyWeatherViewFrame.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: hourlyWeatherViewFrame.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: hourlyWeatherViewFrame.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: hourlyWeatherViewFrame.trailingAnchor, constant: -30),
            //            collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -290)
            collectionView.heightAnchor.constraint(equalToConstant: 170)
            
//            collectionView.topAnchor.constraint(equalTo: hourlyWeatherViewFrame.topAnchor, constant: 495),
//            collectionView.leadingAnchor.constraint(equalTo: hourlyWeatherViewFrame.leadingAnchor, constant: 30),
//            collectionView.trailingAnchor.constraint(equalTo: hourlyWeatherViewFrame.trailingAnchor, constant: -30),
//            //            collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -290)
//            collectionView.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
        
//    콜렉션뷰 계속 스크롤링 처음으로 돌아옴
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        // 스크롤이 멈춘 후 현재 스크롤 위치를 확인하고 필요한 경우 스크롤을 다시 시작합니다.
//        let contentOffsetX = scrollView.contentOffset.x
//        let collectionViewWidth = collectionView.bounds.width
//
//        if contentOffsetX < collectionViewWidth {
//            // 첫 번째 아이템을 넘어갔을 때, 마지막 가상 아이템으로 이동
//            let lastIndexPath = IndexPath(item: numberOfHours - 1, section: 0)
//            collectionView.scrollToItem(at: lastIndexPath, at: .left, animated: false)
//        } else if contentOffsetX >= CGFloat(numberOfHours - 1) * collectionViewWidth {
//            // 마지막 아이템을 넘어갔을 때, 첫 번째 가상 아이템으로 이동
//            let firstIndexPath = IndexPath(item: numberOfHours / 2, section: 0)
//            collectionView.scrollToItem(at: firstIndexPath, at: .left, animated: false)
//        }
//    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfHours
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
        
        //        let itemIndex = indexPath.item % 7
        
        // 이미지와 텍스트를 설정합니다. 예를 들어, 각 셀에 다른 데이터를 표시하려면 아래와 같이 설정할 수 있습니다.
        cell.topLabel.text = "시간"
        cell.imageView.image = UIImage(named: "WeatherIcon-sun")
        cell.bottomLabel.text = "온도"
        
        return cell
    }
        
    // 시간대에 따른 가상의 날씨 데이터를 반환하는 함수
    func getWeatherDataForHour(_ hour: Int) -> String {
        // 실제 날씨 데이터를 가져오거나 시뮬레이션할 수 있습니다.
        // 이 함수에서는 시간대를 기반으로 가상의 데이터를 반환합니다.
        return "예시 날씨 데이터 \(hour)시"
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / CGFloat(7)
        let cellHeight = collectionView.bounds.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
        
    // 컬렉션 뷰의 여백을 조정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
        
    func configure() {
        mainPageTitle.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        mainPageTitle.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        mainPageTitle.backgroundColor = UIColor(red: 1, green: 1.0, blue: 1.0, alpha: 0.7)
        mainPageTitle.font = UIFont(name: "Helvetica-Bold", size: 28)
        mainPageTitle.textAlignment = .left
        mainPageTitle.text = "오늘의 날씨"
            
        currentWeatherFrameTopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        currentWeatherFrameTopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        currentWeatherFrameBottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        currentWeatherFrameBottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        currentWeatherViewFrame.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        currentWeatherViewFrame.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        
        locationOfCurrentWeather.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        locationOfCurrentWeather.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        locationOfCurrentWeather.font = UIFont(name: "Helvetica-Bold", size: 30)
        locationOfCurrentWeather.textAlignment = .center
        locationOfCurrentWeather.text = "제주도"
        
        currentWeatherImage.frame = CGRect(x: 0, y: 0, width: 105, height: 105)
        currentWeatherImage.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let weatherImage = UIImage(named: "WeatherIcon-sun")?.cgImage
        let weatherLayer = CALayer()
        weatherLayer.contents = weatherImage
        weatherLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        weatherLayer.bounds = currentWeatherImage.bounds
        weatherLayer.position = currentWeatherImage.center
        currentWeatherImage.layer.addSublayer(weatherLayer)
        
        currentTemperatuerLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 32)
        currentTemperatuerLabel.textColor = UIColor(red: 0.0, green: 0.62, blue: 0.93, alpha: 0.80)
        currentTemperatuerLabel.font = UIFont(name: "Helvetica-Bold", size: 55)
        currentTemperatuerLabel.textAlignment = .center
        currentTemperatuerLabel.text = "22°C"
        
        currentWeatherLabel.frame = CGRect(x: 0, y: 0, width: 10, height: 22)
        currentWeatherLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        currentWeatherLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        currentWeatherLabel.textAlignment = .center
        currentWeatherLabel.text = "맑음"
        
        dailyTemperatuerLabel.frame = CGRect(x: 0, y: 0, width: 210, height: 22)
        dailyTemperatuerLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        dailyTemperatuerLabel.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        dailyTemperatuerLabel.textAlignment = .center
        let maxtamp = "28.5°C"
        let mintamp = "15.7°C"
        dailyTemperatuerLabel.text = "최고: \(maxtamp) / 최저: \(mintamp)"
        
        hourlyWeatherFrameTopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        hourlyWeatherFrameTopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        hourlyWeatherFrameBottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        hourlyWeatherFrameBottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        hourlyWeatherViewFrame.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        hourlyWeatherViewFrame.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        
        dailyWeatherMentRabel.frame = CGRect(x: 0, y: 0, width: 210, height: 22)
        dailyWeatherMentRabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        dailyWeatherMentRabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        dailyWeatherMentRabel.textAlignment = .left
        dailyWeatherMentRabel.text = "전국적으로 맑은 날씨가 예상됩니다."
        
        UnderLineOfDailyWeatherMent.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        UnderLineOfDailyWeatherMent.layer.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 0.7).cgColor
        
        otherWeatherInfoFrameView.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        otherWeatherInfoFrameView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        
        otherWeatherInfoFrameview2.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        otherWeatherInfoFrameview2.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        
        nameOfWeatherInfoFrameView.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        nameOfWeatherInfoFrameView.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        nameOfWeatherInfoFrameView.font = UIFont(name: "Helvetica-Bold", size: 15)
        nameOfWeatherInfoFrameView.textAlignment = .left
        nameOfWeatherInfoFrameView.text = "공기질"
        
        otherWeatherInfoFrameTopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        otherWeatherInfoFrameTopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        otherWeatherInfoFrameBottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        otherWeatherInfoFrameBottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        nameOfWeatherInfoFrameView2.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        nameOfWeatherInfoFrameView2.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        nameOfWeatherInfoFrameView2.font = UIFont(name: "Helvetica-Bold", size: 15)
        nameOfWeatherInfoFrameView2.textAlignment = .left
        nameOfWeatherInfoFrameView2.text = "자외선 지수"
        
        otherWeatherInfoFrame2TopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        otherWeatherInfoFrame2TopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        otherWeatherInfoFrame2BottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        otherWeatherInfoFrame2BottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        
        let configure = contentView
        // 페이지 타이틀
        mainPageTitle.translatesAutoresizingMaskIntoConstraints = false
        mainPageTitle.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 30).isActive = true
//        mainPageTitle.trailingAnchor.constraint(equalTo: configure.trailingAnchor, constant: 30).isActive = true
        mainPageTitle.clipsToBounds = true
        mainPageTitle.layer.cornerRadius = 25
        mainPageTitle.topAnchor.constraint(equalTo: configure.topAnchor, constant: 10).isActive = true
        
        // 첫 번쨰 프레임
        currentWeatherViewFrame.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherViewFrame.heightAnchor.constraint(equalToConstant: 310).isActive = true
        currentWeatherViewFrame.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        currentWeatherViewFrame.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        currentWeatherViewFrame.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        currentWeatherViewFrame.topAnchor.constraint(equalTo: currentWeatherFrameTopLine.bottomAnchor).isActive = true
        //        currentWeatherViewFrame.topAnchor.constraint(equalTo: configure.topAnchor, constant: 125).isActive = true
        currentWeatherViewFrame.layer.cornerRadius = 15
        
        currentWeatherFrameTopLine.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherFrameTopLine.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        currentWeatherFrameTopLine.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        currentWeatherFrameTopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        currentWeatherFrameTopLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        currentWeatherFrameTopLine.topAnchor.constraint(equalTo: mainPageTitle.bottomAnchor, constant: 10).isActive = true
        currentWeatherFrameTopLine.layer.cornerRadius = 5
        
        locationOfCurrentWeather.translatesAutoresizingMaskIntoConstraints = false
        locationOfCurrentWeather.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        locationOfCurrentWeather.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        locationOfCurrentWeather.heightAnchor.constraint(equalToConstant: 40).isActive = true
        locationOfCurrentWeather.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        locationOfCurrentWeather.topAnchor.constraint(equalTo: currentWeatherFrameTopLine.bottomAnchor, constant: 10).isActive = true
        
        currentWeatherImage.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherImage.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        currentWeatherImage.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        currentWeatherImage.heightAnchor.constraint(equalToConstant: 105).isActive = true
        currentWeatherImage.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        currentWeatherImage.topAnchor.constraint(equalTo: locationOfCurrentWeather.bottomAnchor, constant: 10).isActive = true
        
        currentTemperatuerLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatuerLabel.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        currentTemperatuerLabel.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        currentTemperatuerLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        currentTemperatuerLabel.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        currentTemperatuerLabel.topAnchor.constraint(equalTo: currentWeatherImage.bottomAnchor, constant: 10).isActive = true
        
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherLabel.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        currentWeatherLabel.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        currentWeatherLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        currentWeatherLabel.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        currentWeatherLabel.topAnchor.constraint(equalTo: currentTemperatuerLabel.bottomAnchor, constant: 10).isActive = true
        
        dailyTemperatuerLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyTemperatuerLabel.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        dailyTemperatuerLabel.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        dailyTemperatuerLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        dailyTemperatuerLabel.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        dailyTemperatuerLabel.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor, constant: 10).isActive = true
        
        currentWeatherFrameBottomLine.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherFrameBottomLine.leadingAnchor.constraint(equalTo: currentWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        currentWeatherFrameBottomLine.trailingAnchor.constraint(equalTo: currentWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        currentWeatherFrameBottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        currentWeatherFrameBottomLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        currentWeatherFrameBottomLine.topAnchor.constraint(equalTo: dailyTemperatuerLabel.bottomAnchor, constant: 10).isActive = true
        currentWeatherFrameBottomLine.layer.cornerRadius = 5
        
        
        
        // 두번째 프레임
        hourlyWeatherViewFrame.translatesAutoresizingMaskIntoConstraints = false
        hourlyWeatherViewFrame.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 30).isActive = true
        hourlyWeatherViewFrame.trailingAnchor.constraint(equalTo: configure.trailingAnchor, constant: -30).isActive = true
        hourlyWeatherViewFrame.heightAnchor.constraint(equalToConstant: 110).isActive = true
        hourlyWeatherViewFrame.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 30).isActive = true
        hourlyWeatherViewFrame.topAnchor.constraint(equalTo: currentWeatherFrameBottomLine.bottomAnchor, constant: 10).isActive = true
        hourlyWeatherViewFrame.layer.cornerRadius = 15
        
        hourlyWeatherFrameTopLine.translatesAutoresizingMaskIntoConstraints = false
        hourlyWeatherFrameTopLine.leadingAnchor.constraint(equalTo: hourlyWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        hourlyWeatherFrameTopLine.trailingAnchor.constraint(equalTo: hourlyWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        hourlyWeatherFrameTopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        hourlyWeatherFrameTopLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        hourlyWeatherFrameTopLine.topAnchor.constraint(equalTo: hourlyWeatherViewFrame.bottomAnchor, constant: 0).isActive = true
        hourlyWeatherFrameTopLine.layer.cornerRadius = 5
        
        dailyWeatherMentRabel.translatesAutoresizingMaskIntoConstraints = false
        dailyWeatherMentRabel.leadingAnchor.constraint(equalTo: hourlyWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        dailyWeatherMentRabel.trailingAnchor.constraint(equalTo: hourlyWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        dailyWeatherMentRabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        dailyWeatherMentRabel.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 40).isActive = true
        dailyWeatherMentRabel.topAnchor.constraint(equalTo: hourlyWeatherFrameTopLine.bottomAnchor, constant: 10).isActive = true
        
        UnderLineOfDailyWeatherMent.translatesAutoresizingMaskIntoConstraints = false
        UnderLineOfDailyWeatherMent.leadingAnchor.constraint(equalTo: hourlyWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        UnderLineOfDailyWeatherMent.trailingAnchor.constraint(equalTo: hourlyWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        UnderLineOfDailyWeatherMent.heightAnchor.constraint(equalToConstant: 2).isActive = true
        UnderLineOfDailyWeatherMent.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        UnderLineOfDailyWeatherMent.topAnchor.constraint(equalTo: dailyWeatherMentRabel.bottomAnchor, constant: 10).isActive = true
        UnderLineOfDailyWeatherMent.layer.cornerRadius = 15
        
        hourlyWeatherFrameBottomLine.translatesAutoresizingMaskIntoConstraints = false
        hourlyWeatherFrameBottomLine.leadingAnchor.constraint(equalTo: hourlyWeatherViewFrame.leadingAnchor, constant: 30).isActive = true
        hourlyWeatherFrameBottomLine.trailingAnchor.constraint(equalTo: hourlyWeatherViewFrame.trailingAnchor, constant: -30).isActive = true
        hourlyWeatherFrameBottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        hourlyWeatherFrameBottomLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        hourlyWeatherFrameBottomLine.topAnchor.constraint(equalTo: UnderLineOfDailyWeatherMent.bottomAnchor, constant: 10).isActive = true
        hourlyWeatherFrameBottomLine.layer.cornerRadius = 5
        
        // 세번째 프레임
        otherWeatherInfoFrameView.translatesAutoresizingMaskIntoConstraints = false
        otherWeatherInfoFrameView.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrameView.trailingAnchor.constraint(equalTo: configure.trailingAnchor, constant: -30).isActive = true
        otherWeatherInfoFrameView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        otherWeatherInfoFrameView.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrameView.topAnchor.constraint(equalTo: hourlyWeatherFrameBottomLine.bottomAnchor, constant: 10).isActive = true
        otherWeatherInfoFrameView.layer.cornerRadius = 15
        
        otherWeatherInfoFrameTopLine.translatesAutoresizingMaskIntoConstraints = false
        otherWeatherInfoFrameTopLine.leadingAnchor.constraint(equalTo: otherWeatherInfoFrameView.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrameTopLine.trailingAnchor.constraint(equalTo: otherWeatherInfoFrameView.trailingAnchor, constant: -30).isActive = true
        otherWeatherInfoFrameTopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        otherWeatherInfoFrameTopLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        otherWeatherInfoFrameTopLine.topAnchor.constraint(equalTo: otherWeatherInfoFrameView.bottomAnchor, constant: 10).isActive = true
        otherWeatherInfoFrameTopLine.layer.cornerRadius = 5
        
        nameOfWeatherInfoFrameView.translatesAutoresizingMaskIntoConstraints = false
        nameOfWeatherInfoFrameView.leadingAnchor.constraint(equalTo: otherWeatherInfoFrameView.leadingAnchor, constant: 30).isActive = true
        nameOfWeatherInfoFrameView.trailingAnchor.constraint(equalTo: otherWeatherInfoFrameView.trailingAnchor, constant: -30).isActive = true
        nameOfWeatherInfoFrameView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameOfWeatherInfoFrameView.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 40).isActive = true
        nameOfWeatherInfoFrameView.topAnchor.constraint(equalTo: otherWeatherInfoFrameTopLine.bottomAnchor, constant: 10).isActive = true
        
        otherWeatherInfoFrameBottomLine.translatesAutoresizingMaskIntoConstraints = false
        otherWeatherInfoFrameBottomLine.leadingAnchor.constraint(equalTo: otherWeatherInfoFrameView.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrameBottomLine.trailingAnchor.constraint(equalTo: otherWeatherInfoFrameView.trailingAnchor, constant: -30).isActive = true
        otherWeatherInfoFrameBottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        otherWeatherInfoFrameBottomLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        otherWeatherInfoFrameBottomLine.topAnchor.constraint(equalTo: otherWeatherInfoFrameTopLine.bottomAnchor, constant: 10).isActive = true
        otherWeatherInfoFrameBottomLine.layer.cornerRadius = 5
        
        // 네번째 프레임
        otherWeatherInfoFrameview2.translatesAutoresizingMaskIntoConstraints = false
        otherWeatherInfoFrameview2.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrameview2.trailingAnchor.constraint(equalTo: configure.trailingAnchor, constant: -30).isActive = true
        otherWeatherInfoFrameview2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        otherWeatherInfoFrameview2.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrameview2.topAnchor.constraint(equalTo: otherWeatherInfoFrameBottomLine.bottomAnchor, constant: 10).isActive = true
        otherWeatherInfoFrameview2.layer.cornerRadius = 15
        
        otherWeatherInfoFrame2TopLine.translatesAutoresizingMaskIntoConstraints = false
        otherWeatherInfoFrame2TopLine.leadingAnchor.constraint(equalTo: otherWeatherInfoFrameview2.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrame2TopLine.trailingAnchor.constraint(equalTo: otherWeatherInfoFrameview2.trailingAnchor, constant: -30).isActive = true
        otherWeatherInfoFrame2TopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        otherWeatherInfoFrame2TopLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        otherWeatherInfoFrame2TopLine.topAnchor.constraint(equalTo: otherWeatherInfoFrameview2.bottomAnchor, constant: 10).isActive = true
        otherWeatherInfoFrame2TopLine.layer.cornerRadius = 5
        
        nameOfWeatherInfoFrameView2.translatesAutoresizingMaskIntoConstraints = false
        nameOfWeatherInfoFrameView2.leadingAnchor.constraint(equalTo: otherWeatherInfoFrameview2.leadingAnchor, constant: 30).isActive = true
        nameOfWeatherInfoFrameView2.trailingAnchor.constraint(equalTo: otherWeatherInfoFrameview2.trailingAnchor, constant: -30).isActive = true
        nameOfWeatherInfoFrameView2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameOfWeatherInfoFrameView2.leadingAnchor.constraint(equalTo: configure.leadingAnchor, constant: 40).isActive = true
        nameOfWeatherInfoFrameView2.topAnchor.constraint(equalTo: otherWeatherInfoFrame2TopLine.bottomAnchor, constant: 10).isActive = true
    
        otherWeatherInfoFrame2BottomLine.translatesAutoresizingMaskIntoConstraints = false
        otherWeatherInfoFrame2BottomLine.leadingAnchor.constraint(equalTo: otherWeatherInfoFrameview2.leadingAnchor, constant: 30).isActive = true
        otherWeatherInfoFrame2BottomLine.trailingAnchor.constraint(equalTo: otherWeatherInfoFrameview2.trailingAnchor, constant: -30).isActive = true
        otherWeatherInfoFrame2BottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        otherWeatherInfoFrame2BottomLine.centerXAnchor.constraint(equalTo: configure.centerXAnchor).isActive = true
        otherWeatherInfoFrame2BottomLine.topAnchor.constraint(equalTo: nameOfWeatherInfoFrameView2.bottomAnchor, constant: 10).isActive = true
        otherWeatherInfoFrame2BottomLine.layer.cornerRadius = 5
    }
}
    
class WeatherCell: UICollectionViewCell {
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //        label.frame = CGRect(x: 0, y: 0, width: 40, height: 15)
        label.textColor = UIColor(red: 0, green: 0.0, blue: 0.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 9)
        label.textAlignment = .left
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        //        label.frame = CGRect(x: 0, y: 0, width: 40, height: 15)
        label.textColor = UIColor(red: 0, green: 0.0, blue: 0.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 9)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        // 서브뷰를 스택뷰에 추가합니다.
        verticalStackView.addArrangedSubview(topLabel)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(bottomLabel)
    
        // 스택뷰를 셀의 contentView에 추가합니다.
        contentView.addSubview(verticalStackView)
    
        // Auto Layout 설정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        //        imageView.topAnchor.constraint(equalTo: self.verticalStackView.topAnchor, constant: 0).isActive = true // 위 여백 조절
        //        imageView.bottomAnchor.constraint(equalTo: self.verticalStackView.bottomAnchor, constant: 0).isActive = true // 아래 여백 조절
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 9).isActive = true
        topLabel.textAlignment = .center
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 9).isActive = true
        bottomLabel.textAlignment = .center
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
