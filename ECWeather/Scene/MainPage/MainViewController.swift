
import Alamofire
import SnapKit
import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    lazy var backgroundImageView = UIImageView()
    
    /// 전체 스크롤 뷰
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var scrollViewContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        return stackView
    }()
    
    lazy var mainPageTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 28)
        label.textAlignment = .left
        label.text = " 오늘의 날씨"
        label.layer.cornerRadius = 15
        return label
    }()
    
    lazy var mainPageTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 15
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var currentWeatherFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 15
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var currentWeatherFrameTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var locationOfCurrentWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 32)
        label.textAlignment = .center
        label.text = "제주도"
        return label
    }()
    
    lazy var currentWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        return imageView
    }()
    
    lazy var currentTemperatuerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.0, green: 0.62, blue: 0.93, alpha: 0.80)
        label.font = UIFont(name: "Helvetica-Bold", size: 55)
        label.textAlignment = .center
        label.text = "22°C"
        return label
    }()
    
    lazy var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .center
        label.text = "맑음"
        return label
    }()
    
    lazy var currentDailyTemperatuerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 22)
        label.textAlignment = .center
        let maxtamp = Int(currentWeatherData?.maxTemp ?? 0)
        let mintamp = Int(currentWeatherData?.minTemp ?? 0)
        label.text = "최고: \(maxtamp)°C / 최저: \(mintamp)°C"
        return label
    }()
    
    lazy var currentWeatherFrameBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var hourlyWeatherFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5).cgColor
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    lazy var hourlyWeatherFrameTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var hourlyWeatherMentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textAlignment = .left
        label.text = "전국적으로 맑은 날씨가 예상됩니다."
        return label
    }()
    
    lazy var underLineOfHourlyWeatherView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var todayCollectionView: UICollectionView = {
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
    
    lazy var hourlyWeatherFrameBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var airQualityFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.7).cgColor
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    lazy var topLineOfAirQualityFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var airQualityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textAlignment = .left
        label.text = "습도 / 풍속"
        return label
    }()
    
    lazy var bottomLineOfAirQualityLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.7)
        return view
    }()
    
    lazy var humidityAndWindStranth: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textAlignment = .left
        label.text = "습도 / 풍속"
        return label
    }()
    
    lazy var bottomLineOfAirQualityFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var uvRaysFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7).cgColor
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    lazy var topLineOfUVRaysFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var nameOfUVRaysFrameView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textAlignment = .left
        label.text = "일출 / 일몰"
        return label
    }()
    
    lazy var bottomLineOfUVRaysLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var sunRiseAndSetTime: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00)
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textAlignment = .left
        label.text = "일출 / 일몰"
        return label
    }()
    
    lazy var bottomLineOfUVRaysFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    let cellIdentifier = "WeatherCell"
    var currentWeatherData: CustomWeather?
    var weatherDataList = [CustomWeeklyWeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        todayCollectionView.dataSource = self
        todayCollectionView.delegate = self
        todayCollectionView.register(WeatherCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        setLayout()
        getCurrentWeatherData()
        getCollectionViewWeatherData()
    }
    
    
    func convertToWeatherMent(_ description: String) -> String {
        switch description {
        case "Clear":
            return "전국적으로 맑은 날씨가 예상됩니다."
        case "Clouds":
            return "구름낀 날씨가 예상됩니다."
        case "Rain":
            return "비가 내릴것으로 예상됩니다."
        case "Thunderstorm":
            return "천둥번개를 동반한 우천이 예상됩니다."
        case "Snow":
            return "눈이 내릴것으로 예상됩니다."
        case "Drizzle":
            return "보슬비가 내릴 것으로 예상됩니다."
        default:
            return description
        }
    }
    
    func getCurrentWeatherData() {
        ECWeather.NetworkService.getCurrentWeather(lat: DataManager.shared.latitude ?? 0, lon: DataManager.shared.longitude ?? 0) { [weak self] weatherData in
            if let weatherData = weatherData {
                NetworkService.getIcon(iconCode: weatherData.icon) { icon in
                    DispatchQueue.main.async {
                        self?.currentWeatherImageView.image = UIImage(data: icon ?? Data())
                    }
                }
                self?.locationOfCurrentWeatherLabel.text = weatherData.name
                self?.currentTemperatuerLabel.text = "\(Int(weatherData.currentTemp))°C"
                self?.currentWeatherLabel.text = weatherData.description
                self?.currentDailyTemperatuerLabel.text = "최고: \(Int(weatherData.maxTemp))°C / 최저: \(Int(weatherData.minTemp))°C"
                
                self?.hourlyWeatherMentLabel.text = self?.convertToWeatherMent(weatherData.mainDescription)
                self?.humidityAndWindStranth.text = "습도: \(weatherData.humidity) / 풍속: \(weatherData.windSpeed)"
                self?.sunRiseAndSetTime.text = "일출시간: \(weatherData.sunriseTimestamp) / 일몰시간: \(weatherData.sunsetTimestamp)"
               
            } else {
                print("주간 날씨 데이터를 가져오는 데 실패했습니다.")
            }
        }
    }

    func setLayout() {
        setBackgroundImageView()
        setScrollViewLayout()
        setScrollViewContentViewLayout()
        setMainTitleLayout()
        
        setCurrentWeatherViewLayout()
        setCurrentWeatherViewTopLineLayout()
        setCurrentWeatherViewLocationLabelLayout()
        setCurrentWeatherViewIconImageLayout()
        setCurrentWeatherViewTemperatureLabelLayout()
        setCurrentWeatherViewWeatherLabelLayout()
        setCurrentWeatherViewDailyTemperatureLabelLayout()
        setCurrentWeatherViewBottomLineLayout()

        setHourlyWeatherViewLayout()
        setHourlyWeatherViewTopLineLayout()
        setHourlyWeatherViewMentLabelLayout()
        setHourlyWeatherViewMentLabelUnderLineLayout()
        setHourlyWeatherViewCollectionViewLayout()
        setHourlyWeatherViewBottomLineLayout()

        setAirQualityViewLayout()
        setAirQualityViewTopLineLayout()
        setAirQualityViewNameLabelLayout()
        setAirQualityViewUnderLineLayout()
        sethumidityAndWindStranthLayout()
        setAirQualityViewBottomLineLayout()

        setUVRaysViewLayout()
        setUVRaysViewTopLineLayout()
        setUVRaysViewMainLabelLayout()
        setUVRaysViewUnderLineLayout()
        setSunRiseAndSetTimeLayout()
        setUVRaysViewBottomLineLayout()

        scrollViewContentView.setCustomSpacing(10, after: mainPageTitleLabel)
        
        scrollViewContentView.setCustomSpacing(10, after: currentWeatherFrameView)
        currentWeatherFrameView.setCustomSpacing(5, after: currentWeatherFrameTopLine)
        currentWeatherFrameView.setCustomSpacing(5, after: locationOfCurrentWeatherLabel)
        currentWeatherFrameView.setCustomSpacing(5, after: currentWeatherImageView)
        currentWeatherFrameView.setCustomSpacing(5, after: currentTemperatuerLabel)
        currentWeatherFrameView.setCustomSpacing(5, after: currentWeatherLabel)
        currentWeatherFrameView.setCustomSpacing(5, after: currentDailyTemperatuerLabel)
        currentWeatherFrameView.setCustomSpacing(15, after: currentWeatherFrameBottomLine)
            
        scrollViewContentView.setCustomSpacing(10, after: hourlyWeatherFrameView)
        hourlyWeatherFrameView.setCustomSpacing(20, after: hourlyWeatherFrameTopLine)
        hourlyWeatherFrameView.setCustomSpacing(5, after: hourlyWeatherMentLabel)
        hourlyWeatherFrameView.setCustomSpacing(10, after: underLineOfHourlyWeatherView)
        hourlyWeatherFrameView.setCustomSpacing(10, after: todayCollectionView)
        hourlyWeatherFrameView.setCustomSpacing(15, after: hourlyWeatherFrameBottomLine)
            
        scrollViewContentView.setCustomSpacing(10, after: airQualityFrameView)
        airQualityFrameView.setCustomSpacing(5, after: topLineOfAirQualityFrameView)
        airQualityFrameView.setCustomSpacing(5, after: airQualityNameLabel)
        airQualityFrameView.setCustomSpacing(5, after: bottomLineOfAirQualityLabelView)
        airQualityFrameView.setCustomSpacing(5, after: humidityAndWindStranth)
        airQualityFrameView.setCustomSpacing(15, after: bottomLineOfAirQualityFrameView)
            
        scrollViewContentView.setCustomSpacing(10, after: uvRaysFrameView)
        uvRaysFrameView.setCustomSpacing(5, after: topLineOfUVRaysFrameView)
        uvRaysFrameView.setCustomSpacing(5, after: nameOfUVRaysFrameView)
        uvRaysFrameView.setCustomSpacing(10, after: bottomLineOfUVRaysLabelView)
        uvRaysFrameView.setCustomSpacing(10, after: sunRiseAndSetTime)
        uvRaysFrameView.setCustomSpacing(15, after: bottomLineOfUVRaysFrameView)
    }
        
    func setBackgroundImageView() {
        view.addSubview(backgroundImageView)
            
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
            
        NetworkService.getCurrentWeather(lat: DataManager.shared.latitude!, lon: DataManager.shared.longitude!) { weather in
            let backgroundImage = weather?.mainDescription
            switch backgroundImage {
            case BackgroundImage.Clouds.rawValue: self.backgroundImageView.image = BackgroundImage.Clouds.image
            case BackgroundImage.Clear.rawValue: self.backgroundImageView.image = BackgroundImage.Clear.image
            case BackgroundImage.Snow.rawValue: self.backgroundImageView.image = BackgroundImage.Snow.image
            case BackgroundImage.Rain.rawValue: self.backgroundImageView.image = BackgroundImage.Rain.image
            case BackgroundImage.Drizzle.rawValue: self.backgroundImageView.image = BackgroundImage.Drizzle.image
            case BackgroundImage.Thunderstorm.rawValue: self.backgroundImageView.image = BackgroundImage.Thunderstorm.image
            case .none: self.backgroundImageView.image = BackgroundImage.Mist.image
            case .some:
                break
            }
        }
    }
        
    func setScrollViewLayout() {
        view.addSubview(mainScrollView)
            
        mainScrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(0)
        }
    }
        
    func setScrollViewContentViewLayout() {
        mainScrollView.addSubview(scrollViewContentView)

        mainScrollView.contentLayoutGuide.snp.makeConstraints {
            $0.edges.equalTo(scrollViewContentView)
        }
        scrollViewContentView.snp.makeConstraints {
            $0.edges.equalTo(mainScrollView)
            $0.width.equalTo(mainScrollView)
        }
    }
    
    func setMainTitleLayout() {
        scrollViewContentView.addArrangedSubview(mainPageTitleLabel)
            
        mainPageTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(scrollViewContentView).offset(10)
        }
    }
    
    func setCurrentWeatherViewLayout() {
        scrollViewContentView.addArrangedSubview(currentWeatherFrameView)
            
        currentWeatherFrameView.snp.makeConstraints {
            $0.top.equalTo(mainPageTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(scrollViewContentView).offset(20)
            $0.trailing.equalTo(scrollViewContentView).offset(-20)
        }
    }
        
    func setCurrentWeatherViewTopLineLayout() {
        currentWeatherFrameView.addArrangedSubview(currentWeatherFrameTopLine)
            
        currentWeatherFrameTopLine.snp.makeConstraints {
            $0.top.equalTo(currentWeatherFrameView.snp.top)
            $0.leading.equalTo(currentWeatherFrameView).offset(25)
            $0.trailing.equalTo(currentWeatherFrameView).offset(-25)
            $0.height.equalTo(2)
        }
    }
        
    func setCurrentWeatherViewLocationLabelLayout() {
        currentWeatherFrameView.addArrangedSubview(locationOfCurrentWeatherLabel)

    }
        
    func setCurrentWeatherViewIconImageLayout() {
        currentWeatherFrameView.addArrangedSubview(currentWeatherImageView)
            
        currentWeatherImageView.snp.makeConstraints {
            $0.height.width.equalTo(145)
        }
    }
        
    func setCurrentWeatherViewTemperatureLabelLayout() {
        currentWeatherFrameView.addArrangedSubview(currentTemperatuerLabel)
            
        currentTemperatuerLabel.snp.makeConstraints {
            $0.leading.equalTo(currentWeatherFrameView).offset(10)
            $0.trailing.equalTo(currentWeatherFrameView).offset(-10)
        }
    }
        
    func setCurrentWeatherViewWeatherLabelLayout() {
        currentWeatherFrameView.addArrangedSubview(currentWeatherLabel)
    }
        
    func setCurrentWeatherViewDailyTemperatureLabelLayout() {
        currentWeatherFrameView.addArrangedSubview(currentDailyTemperatuerLabel)
    }
        
    func setCurrentWeatherViewBottomLineLayout() {
        currentWeatherFrameView.addArrangedSubview(currentWeatherFrameBottomLine)
            
        currentWeatherFrameBottomLine.snp.makeConstraints {
            $0.leading.equalTo(currentWeatherFrameView).offset(25)
            $0.trailing.equalTo(currentWeatherFrameView).offset(-25)
            $0.height.equalTo(2)
            $0.bottom.equalTo(currentWeatherFrameView.snp.bottom)
        }
    }
        
    // 두번째 프레임
    func setHourlyWeatherViewLayout() {
        scrollViewContentView.addArrangedSubview(hourlyWeatherFrameView)
            
        hourlyWeatherFrameView.snp.makeConstraints {
            $0.top.equalTo(currentWeatherFrameView.snp.bottom).offset(20)
            $0.leading.equalTo(scrollViewContentView).offset(20)
            $0.trailing.equalTo(scrollViewContentView).offset(-20)
        }
    }
        
    func setHourlyWeatherViewTopLineLayout() {
        hourlyWeatherFrameView.addArrangedSubview(hourlyWeatherFrameTopLine)
            
        hourlyWeatherFrameTopLine.snp.makeConstraints {
            $0.height.equalTo(2)
        }
    }
        
    func setHourlyWeatherViewMentLabelLayout() {
        hourlyWeatherFrameView.addArrangedSubview(hourlyWeatherMentLabel)
      
        hourlyWeatherMentLabel.snp.makeConstraints {
            $0.leading.equalTo(hourlyWeatherFrameView).offset(5)
        }
    }
        
    func setHourlyWeatherViewMentLabelUnderLineLayout() {
        hourlyWeatherFrameView.addArrangedSubview(underLineOfHourlyWeatherView)
            
        underLineOfHourlyWeatherView.snp.makeConstraints {
            $0.height.equalTo(2)
        }
    }
        
    func setHourlyWeatherViewCollectionViewLayout() {
        hourlyWeatherFrameView.addArrangedSubview(todayCollectionView)
            
        todayCollectionView.snp.makeConstraints {
            $0.top.equalTo(underLineOfHourlyWeatherView.snp.bottom)
            $0.height.equalTo(85)
            $0.leading.equalTo(hourlyWeatherFrameView).offset(10)
            $0.trailing.equalTo(hourlyWeatherFrameView).offset(-10)
            $0.bottom.equalTo(hourlyWeatherFrameView.snp.bottom).offset(-5)
        }
    }
        
    func setHourlyWeatherViewBottomLineLayout() {
        hourlyWeatherFrameView.addArrangedSubview(hourlyWeatherFrameBottomLine)
            
        hourlyWeatherFrameBottomLine.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.leading.equalTo(hourlyWeatherFrameView).offset(25)
            $0.trailing.equalTo(hourlyWeatherFrameView).offset(-25)
        }
    }
        
    // 세번째 프레임
    func setAirQualityViewLayout() {
        scrollViewContentView.addArrangedSubview(airQualityFrameView)
            
        airQualityFrameView.snp.makeConstraints {
            $0.top.equalTo(hourlyWeatherFrameView.snp.bottom).offset(20)
            $0.leading.equalTo(scrollViewContentView).offset(20)
            $0.trailing.equalTo(scrollViewContentView).offset(-20)
        }
    }
        
    func setAirQualityViewTopLineLayout() {
        airQualityFrameView.addArrangedSubview(topLineOfAirQualityFrameView)
            
        topLineOfAirQualityFrameView.snp.makeConstraints {
            $0.top.equalTo(airQualityFrameView.snp.top)
            $0.height.equalTo(2)
            $0.leading.equalTo(airQualityFrameView).offset(25)
            $0.trailing.equalTo(airQualityFrameView).offset(-25)
        }
    }
    
    func setAirQualityViewNameLabelLayout() {
        airQualityFrameView.addArrangedSubview(airQualityNameLabel)
            
        airQualityNameLabel.snp.makeConstraints {
            $0.leading.equalTo(airQualityFrameView).offset(5)
        }
    }
        
    func setAirQualityViewUnderLineLayout() {
        airQualityFrameView.addArrangedSubview(bottomLineOfAirQualityLabelView)
            
        bottomLineOfAirQualityLabelView.snp.makeConstraints {
            $0.top.equalTo(airQualityNameLabel.snp.bottom)
            $0.height.equalTo(2)
            $0.leading.equalTo(airQualityFrameView).offset(25)
            $0.trailing.equalTo(airQualityFrameView).offset(-25)
        }
    }
    
    func sethumidityAndWindStranthLayout() {
        airQualityFrameView.addArrangedSubview(humidityAndWindStranth)
        
        humidityAndWindStranth.snp.makeConstraints {
            $0.leading.equalTo(airQualityFrameView).offset(5)
        }
    }
    
    func setAirQualityViewBottomLineLayout() {
        airQualityFrameView.addArrangedSubview(bottomLineOfAirQualityFrameView)
            
        bottomLineOfAirQualityFrameView.snp.makeConstraints {
            $0.top.equalTo(humidityAndWindStranth.snp.bottom)
            $0.height.equalTo(2)
            $0.leading.equalTo(airQualityFrameView).offset(25)
            $0.trailing.equalTo(airQualityFrameView).offset(-25)
        }
    }
        
    // 네번째 뷰
    func setUVRaysViewLayout() {
        scrollViewContentView.addArrangedSubview(uvRaysFrameView)
            
        uvRaysFrameView.snp.makeConstraints {
            $0.leading.equalTo(scrollViewContentView).offset(20)
            $0.trailing.equalTo(scrollViewContentView).offset(-20)
        }
    }
        
    func setUVRaysViewTopLineLayout() {
        uvRaysFrameView.addArrangedSubview(topLineOfUVRaysFrameView)
            
        topLineOfUVRaysFrameView.snp.makeConstraints {
            $0.top.equalTo(uvRaysFrameView.snp.top)
            $0.height.equalTo(2)
            $0.leading.equalTo(uvRaysFrameView).offset(25)
            $0.trailing.equalTo(uvRaysFrameView).offset(-25)
        }
    }
        
    func setUVRaysViewMainLabelLayout() {
        uvRaysFrameView.addArrangedSubview(nameOfUVRaysFrameView)
            
        nameOfUVRaysFrameView.snp.makeConstraints {
            $0.leading.equalTo(uvRaysFrameView).offset(5)
        }
    }
        
    func setUVRaysViewUnderLineLayout() {
        uvRaysFrameView.addArrangedSubview(bottomLineOfUVRaysLabelView)
            
        bottomLineOfUVRaysLabelView.snp.makeConstraints {
            $0.top.equalTo(nameOfUVRaysFrameView.snp.bottom).offset(5)
            $0.height.equalTo(2)
            $0.leading.equalTo(uvRaysFrameView).offset(25)
            $0.trailing.equalTo(uvRaysFrameView).offset(-25)
        }
    }
    
    func setSunRiseAndSetTimeLayout() {
        uvRaysFrameView.addArrangedSubview(sunRiseAndSetTime)
        
        sunRiseAndSetTime.snp.makeConstraints {
            $0.leading.equalTo(uvRaysFrameView).offset(5)
        }
    }
    
    func setUVRaysViewBottomLineLayout() {
        uvRaysFrameView.addArrangedSubview(bottomLineOfUVRaysFrameView)
            
        bottomLineOfUVRaysFrameView.snp.makeConstraints {
            $0.top.equalTo(uvRaysFrameView.snp.bottom)
            $0.height.equalTo(2)
            $0.leading.equalTo(uvRaysFrameView).offset(25)
            $0.trailing.equalTo(uvRaysFrameView).offset(-25)
        }
    }
        
    func getCollectionViewWeatherData() {
        NetworkService.getWeeklyWeather(lat: DataManager.shared.latitude ?? 0, lon: DataManager.shared.longitude ?? 0) { [weak self] weatherData in
            if let collectionViewWeatherData = weatherData {
                self?.weatherDataList = collectionViewWeatherData
                self?.todayCollectionView.reloadData()
            }
        }
    }

    func check(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: date) {
            let currentDate = Date()
            if Calendar.current.isDate(date, inSameDayAs: currentDate) {
                return true
            }
        }
        return false
    }
    
    func temp(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: time) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "dd HH:mm"
            let timeString = timeFormatter.string(from: date)
            return timeString
        }
        return ""
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDataList.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            return UICollectionViewCell()
        }
        
        cell.topLabel.text = "\(weatherDataList[indexPath.row].dateTime.toDate()!.toTimeString()) 시"
        cell.bottomLabel.text = weatherDataList[indexPath.row].description
        NetworkService.getIcon(iconCode: weatherDataList[indexPath.row].icon) { icon in
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: icon ?? Data())
            }
        }
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
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
    

