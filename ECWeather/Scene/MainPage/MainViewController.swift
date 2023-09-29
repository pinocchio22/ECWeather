//
//  ViewController.swift
//  testForWeatherProject(team)
//
//  Created by t2023-m0064 on 2023/09/26.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "WeatherCell"
    let numberOfHours = 7
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // collectionView 설정
        view.addSubview(collectionView)
        
        // Auto Layout 설정
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 445),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        
        weatherNowFramePart()
        weatherTodayPart()
        weatherFramePart3()
        weatherNowFramePart4()
        restFrameLine()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfHours
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        // 각 시간대에 해당하는 날씨 데이터를 가져와서 cell에 표시
        let imageName = "WeatherIcon-sun" // 에셋 카탈로그에 등록한 이미지 이름
        if let image = UIImage(named: imageName) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = cell.contentView.bounds
            cell.contentView.addSubview(imageView)
        }
        return cell
        
        
        let hour = indexPath.item
        let weatherLabel = UILabel(frame: cell.bounds)
        weatherLabel.textAlignment = .center
        weatherLabel.text = getWeatherDataForHour(hour)
        cell.contentView.addSubview(weatherLabel)
        return cell
    }
    // 시간대에 따른 가상의 날씨 데이터를 반환하는 함수
    func getWeatherDataForHour(_ hour: Int) -> String {
        // 실제 날씨 데이터를 가져오거나 시뮬레이션할 수 있습니다.
        // 이 함수에서는 시간대를 기반으로 가상의 데이터를 반환합니다.
        return "예시 날씨 데이터 \(hour)시"
    }
    // 컬렉션 뷰 셀의 크기를 조정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width - 20
        let cellHeight = collectionView.bounds.height - 40
        return CGSize(width: cellWidth, height: cellHeight)
    }
    // 컬렉션 뷰의 여백을 조정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
    
    
    
    
    
    private let dailyWeatherInfo = ["지금", "12시", "1시", "2시", "3시", "4시", "5시", "6시"]
    
    
    // MARK: - weatherNowView
    
    func weatherNowFramePart() {
        weatherNowFameLine()
        weatherNowFrame()
        localWeather()
        weatherImage()
        nowTemperature()
        weatherName()
        dailyTemperature()
    }
    
    func weatherNowFameLine() {
        // Auto layout, variables, and unit scale are not yet supported
        let weatherNowFrameTopLine = UIView()
        weatherNowFrameTopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherNowFrameTopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent = view!
        parent.addSubview(weatherNowFrameTopLine)
        weatherNowFrameTopLine.translatesAutoresizingMaskIntoConstraints = false
        weatherNowFrameTopLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherNowFrameTopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherNowFrameTopLine.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        weatherNowFrameTopLine.topAnchor.constraint(equalTo: parent.topAnchor, constant: 105).isActive = true
        weatherNowFrameTopLine.layer.cornerRadius = 5
        
        // Auto layout, variables, and unit scale are not yet supported
        let weatherNowFrameBottomLine = UIView()
        weatherNowFrameBottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherNowFrameBottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent2 = view!
        parent2.addSubview(weatherNowFrameBottomLine)
        weatherNowFrameBottomLine.translatesAutoresizingMaskIntoConstraints = false
        weatherNowFrameBottomLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherNowFrameBottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherNowFrameBottomLine.centerXAnchor.constraint(equalTo: parent2.centerXAnchor).isActive = true
        weatherNowFrameBottomLine.topAnchor.constraint(equalTo: parent2.topAnchor, constant: 405).isActive = true
        weatherNowFrameBottomLine.layer.cornerRadius = 5
    }
    
    func weatherNowFrame() {
        let nowFrameView = UIView()
        nowFrameView.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        nowFrameView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        
        let parent = view!
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
        localLabel.font = UIFont(name: "Helvetica-Bold", size: 30)
        // Line height: 22.47 pt
        localLabel.textAlignment = .center
        localLabel.text = "제주도"
        
        let parent = view!
        parent.addSubview(localLabel)
        localLabel.translatesAutoresizingMaskIntoConstraints = false
        localLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        localLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        localLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        localLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 110).isActive = true
    }
    
    // 날씨 클래스, 날씨 - 이미지
    func weatherImage() {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 105, height: 105)
        imageView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let weatherImage = UIImage(named: "WeatherIcon-sun")?.cgImage
        let weatherLayer = CALayer()
        weatherLayer.contents = weatherImage
        weatherLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        weatherLayer.bounds = imageView.bounds
        weatherLayer.position = imageView.center
        imageView.layer.addSublayer(weatherLayer)
        
        let parent = view!
        parent.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 105).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        imageView.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 155).isActive = true
    }
    
    // 날씨 클래스, 온도
    func nowTemperature() {
        let temperatuerLabel = UILabel()
        temperatuerLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 32)
        temperatuerLabel.textColor = UIColor(red: 0.0, green: 0.62, blue: 0.93, alpha: 0.80)
        temperatuerLabel.font = UIFont(name: "Helvetica-Bold", size: 55)
        temperatuerLabel.textAlignment = .center
        temperatuerLabel.text = "22°C"
        
        let parent = view!
        parent.addSubview(temperatuerLabel)
        temperatuerLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatuerLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        temperatuerLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        temperatuerLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        temperatuerLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 270).isActive = true
    }
    
    // 날씨클래스, 날씨 - 날씨명
    func weatherName() {
        let weatherNameLabel = UILabel()
        weatherNameLabel.frame = CGRect(x: 0, y: 0, width: 10, height: 22)
        weatherNameLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        weatherNameLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        // Line height: 22.47 pt
        weatherNameLabel.textAlignment = .center
        weatherNameLabel.text = "맑음"
        
        let parent = view!
        parent.addSubview(weatherNameLabel)
        weatherNameLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherNameLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        weatherNameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        //        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        //        view.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        weatherNameLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        weatherNameLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 340).isActive = true
    }
    
    // 최고 온도 / 최저 온도
    func dailyTemperature() {
        let dtLabel = UILabel()
        dtLabel.frame = CGRect(x: 0, y: 0, width: 210, height: 22)
        dtLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        dtLabel.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        // Line height: 22.47 pt
        dtLabel.textAlignment = .center
        dtLabel.text = "최고: 28.5°C / 최저: 15.7°C"
        
        let parent = view!
        parent.addSubview(dtLabel)
        dtLabel.translatesAutoresizingMaskIntoConstraints = false
        dtLabel.widthAnchor.constraint(equalToConstant: 210).isActive = true
        dtLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        dtLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        dtLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 370).isActive = true
    }
    
    // MARK: - weatherTodayView
    
    func weatherTodayPart() {
        weatherTodayFrameLine()
        weatherTodayFrame()
        weatherMent()
        weatherTodayMentUnderLine()
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 465).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: 310).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func weatherTodayFrameLine() {
        // Auto layout, variables, and unit scale are not yet supported
        let weatherTodayFrameTopLine = UIView()
        weatherTodayFrameTopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherTodayFrameTopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent = view!
        parent.addSubview(weatherTodayFrameTopLine)
        weatherTodayFrameTopLine.translatesAutoresizingMaskIntoConstraints = false
        weatherTodayFrameTopLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherTodayFrameTopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherTodayFrameTopLine.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        weatherTodayFrameTopLine.topAnchor.constraint(equalTo: parent.topAnchor, constant: 427).isActive = true
        weatherTodayFrameTopLine.layer.cornerRadius = 5
        
        // Auto layout, variables, and unit scale are not yet supported
        let weatherTodayFrameBottomLine = UIView()
        weatherTodayFrameBottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherTodayFrameBottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent2 = view!
        parent2.addSubview(weatherTodayFrameBottomLine)
        weatherTodayFrameBottomLine.translatesAutoresizingMaskIntoConstraints = false
        weatherTodayFrameBottomLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherTodayFrameBottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherTodayFrameBottomLine.centerXAnchor.constraint(equalTo: parent2.centerXAnchor).isActive = true
        weatherTodayFrameBottomLine.topAnchor.constraint(equalTo: parent2.topAnchor, constant: 537).isActive = true
        weatherTodayFrameBottomLine.layer.cornerRadius = 5
    }
    
    func weatherTodayFrame() {
        // Auto layout, variables, and unit scale are not yet supported
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        view.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        //        view.layer.borderWidth = 5
        //        view.layer.borderColor = UIColor(red: 0.0, green: 0, blue: 0, alpha: 0).cgColor
        
        let parent = self.view!
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
        view.font = UIFont(name: "Helvetica-Bold", size: 15)
        // Line height: 22.47 pt
        view.textAlignment = .left
        view.text = "전국적으로 맑은 날씨가 예상됩니다."
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 310).isActive = true
        view.heightAnchor.constraint(equalToConstant: 22).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 40).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 435).isActive = true
    }
    
    func weatherTodayMentUnderLine() {
        // Auto layout, variables, and unit scale are not yet supported
        let weatherTodayMentUnderLine = UIView()
        weatherTodayMentUnderLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherTodayMentUnderLine.layer.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 0.7).cgColor
        //        nowFrameView.layer.borderWidth = 5
        //        nowFrameView.layer.borderColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00).cgColor
        
        let parent = view!
        parent.addSubview(weatherTodayMentUnderLine)
        weatherTodayMentUnderLine.translatesAutoresizingMaskIntoConstraints = false
        weatherTodayMentUnderLine.widthAnchor.constraint(equalToConstant: 330).isActive = true
        weatherTodayMentUnderLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherTodayMentUnderLine.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        weatherTodayMentUnderLine.topAnchor.constraint(equalTo: parent.topAnchor, constant: 460).isActive = true
        weatherTodayMentUnderLine.layer.cornerRadius = 15
    }
    
    // 날씨 콜렉션뷰, 시간별 날씨 이미지, 온도
    
    // MARK: - RestWeatherInfoViews
    
    
    func weatherFramePart3(){
        weatherNowFrame3()
        nameOfWeatherNowFrame3()
    }
    
    
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
    
    
    
    func nameOfWeatherNowFrame3() {
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        nameLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        // Line height: 22.47 pt
        nameLabel.textAlignment = .left
        nameLabel.text = "공기질"
        
        let parent = view!
        parent.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 40).isActive = true
        nameLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 565).isActive = true
    }
    
    
    
    
    
    func weatherNowFramePart4(){
        weatherNowFrame4()
        nameOfWeatherNowFrame4()
    }
    
    
    func weatherNowFrame4() {
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
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 640).isActive = true
        view.layer.cornerRadius = 15
    }
    
    
    func nameOfWeatherNowFrame4() {
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        nameLabel.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        // Line height: 22.47 pt
        nameLabel.textAlignment = .left
        nameLabel.text = "자외선 지수"
        
        let parent = view!
        parent.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 40).isActive = true
        nameLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 645).isActive = true
    }
    
    
    
    func restFrameLine() {
        // 세번째 뷰 프레임 아웃라인
        let weatherNowFrame3TopLine = UIView()
        weatherNowFrame3TopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherNowFrame3TopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent = view!
        parent.addSubview(weatherNowFrame3TopLine)
        weatherNowFrame3TopLine.translatesAutoresizingMaskIntoConstraints = false
        weatherNowFrame3TopLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherNowFrame3TopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherNowFrame3TopLine.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        weatherNowFrame3TopLine.topAnchor.constraint(equalTo: parent.topAnchor, constant: 560).isActive = true
        weatherNowFrame3TopLine.layer.cornerRadius = 5
        
        let weatherNowFrame3BottomLine = UIView()
        weatherNowFrame3BottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherNowFrame3BottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent2 = view!
        parent2.addSubview(weatherNowFrame3BottomLine)
        weatherNowFrame3BottomLine.translatesAutoresizingMaskIntoConstraints = false
        weatherNowFrame3BottomLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherNowFrame3BottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherNowFrame3BottomLine.centerXAnchor.constraint(equalTo: parent2.centerXAnchor).isActive = true
        weatherNowFrame3BottomLine.topAnchor.constraint(equalTo: parent2.topAnchor, constant: 620).isActive = true
        weatherNowFrame3BottomLine.layer.cornerRadius = 5
        
        // 네번째 뷰 프레임 아웃라인
        let weatherNowFrame4TopLine = UIView()
        weatherNowFrame4TopLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherNowFrame4TopLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent3 = view!
        parent3.addSubview(weatherNowFrame4TopLine)
        weatherNowFrame4TopLine.translatesAutoresizingMaskIntoConstraints = false
        weatherNowFrame4TopLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherNowFrame4TopLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherNowFrame4TopLine.centerXAnchor.constraint(equalTo: parent3.centerXAnchor).isActive = true
        weatherNowFrame4TopLine.topAnchor.constraint(equalTo: parent3.topAnchor, constant: 640).isActive = true
        weatherNowFrame4TopLine.layer.cornerRadius = 5
        
        let weatherNowFrame4BottomLine = UIView()
        weatherNowFrame4BottomLine.frame = CGRect(x: 0, y: 0, width: 345, height: 59)
        weatherNowFrame4BottomLine.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        
        let parent4 = view!
        parent4.addSubview(weatherNowFrame4BottomLine)
        weatherNowFrame4BottomLine.translatesAutoresizingMaskIntoConstraints = false
        weatherNowFrame4BottomLine.widthAnchor.constraint(equalToConstant: 310).isActive = true
        weatherNowFrame4BottomLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        weatherNowFrame4BottomLine.centerXAnchor.constraint(equalTo: parent4.centerXAnchor).isActive = true
        weatherNowFrame4BottomLine.topAnchor.constraint(equalTo: parent4.topAnchor, constant: 700).isActive = true
        weatherNowFrame4BottomLine.layer.cornerRadius = 5
    }
}
