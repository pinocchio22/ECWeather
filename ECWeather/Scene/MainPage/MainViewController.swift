
import UIKit
import SnapKit
import Alamofire






class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    
    /// 배경 이미지 뷰
    lazy var backgroundImageView = UIImageView()
    
    
    /// 전체 스크롤 뷰
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    /// 전체 스크롤 내부 뷰
    lazy var scrollViewContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 1, green: 1.0, blue: 1.0, alpha: 0.7)
        return stackView
    }()
    
    /// 맨 위 label "오늘의 날씨"
    lazy var mainPageTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        //        label.backgroundColor = UIColor(red: 1, green: 1.0, blue: 1.0, alpha: 0.7)
        label.font = UIFont(name: "Helvetica-Bold", size: 28)
        label.textAlignment = .left
        label.text = "오늘의 날씨"
        label.layer.cornerRadius = 25
        return label
    }()
    
    /// 현재 날씨 맨 위에 제일 큰
    lazy var currentWeatherFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 15
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3)
        return stackView
    }()
    
    /// 현재 날씨 - 맨 위에 구분선
    lazy var currentWeatherFrameTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 현재 날씨 - 현 위치 label
    lazy var locationOfCurrentWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        label.textAlignment = .center
        label.text = "제주도"
        return label
    }()
    
    /// 현재 날씨 - 날씨 아이콘 이미지
    lazy var currentWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        imageView.frame = CGRect(x: 0, y: 0, width: 105, height: 105)
        let weatherImage = UIImage(named: "WeatherIcon-sun")?.cgImage
        let weatherLayer = CALayer()
        weatherLayer.contents = weatherImage
        weatherLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: -0.01))
        weatherLayer.bounds = imageView.bounds
        weatherLayer.position = imageView.center
        imageView.layer.addSublayer(weatherLayer)
        return imageView
    }()
    
    /// 현재 날씨 - 현재 온도
    lazy var currentTemperatuerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.0, green: 0.62, blue: 0.93, alpha: 0.80)
        label.font = UIFont(name: "Helvetica-Bold", size: 55)
        label.textAlignment = .center
        label.text = "22°C"
        return label
    }()
    
    /// 현재 날씨 - 현재 날씨(ex. 맑음, 흐림, ...)
    lazy var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .center
        label.text = "맑음"
        return label
    }()
    
    /// 현재 날씨 - 오늘 온도(ex. 최고: 26, 최저: 20)
    lazy var currentDailyTemperatuerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        label.textAlignment = .center
        let maxtamp = Int(currentWeatherData?.maxTemp ?? 0)
        let mintamp = Int(currentWeatherData?.minTemp ?? 0)
        label.text = "최고: \(maxtamp)°C / 최저: \(mintamp)°C"
        return label
    }()
    
    /// 현재 날씨 - 맨 아래에 구분선
    lazy var currentWeatherFrameBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 오늘 날씨 프레임 뷰
    lazy var hourlyWeatherFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    /// 오늘 날씨 - 맨 위에 구분선
    lazy var hourlyWeatherFrameTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 오늘 날씨 - 위에 멘트(ex. 오늘 날씨는 좋은데요?)
    lazy var hourlyWeatherMentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        label.textAlignment = .left
        label.text = "전국적으로 맑은 날씨가 예상됩니다."
        return label
    }()
    
    /// 오늘 날씨 - 멘트 아래 구분선
    lazy var underLineOfHourlyWeatherView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 오늘 날씨 - collectionview
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
    
    /// 오늘 날씨 - 맨 아래에 구분선
    lazy var hourlyWeatherFrameBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 대기질 프레임 뷰
    lazy var airQualityFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    /// 대기질 - 맨 위에 구분선
    lazy var topLineOfAirQualityFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 대기질 - "습도 / 풍속" label
    lazy var airQualityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        label.textAlignment = .left
        label.text = "습도 / 풍속"
        return label
    }()
    
    /// 대기질 - "대기질" label 아래에 구분선
    lazy var bottomLineOfAirQualityLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var humidityAndWindStranth: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .left
        label.text = "습도 / 풍속"
        return label
    }()
    
    
    /// 대기질 - 맨 아래에 구분선
    lazy var bottomLineOfAirQualityFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 자외선 지수 프레임 뷰
    lazy var uvRaysFrameView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3).cgColor
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    /// 자외선 지수 - 맨 위에 구분선
    lazy var topLineOfUVRaysFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    /// 자외선 지수 - "일출 / 일몰" label
    lazy var nameOfUVRaysFrameView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        label.textAlignment = .left
        label.text = "일출 / 일몰"
        return label
    }()
    
    /// 자외선 지수 - "자외선 지수" label 아래에 구분선
    lazy var bottomLineOfUVRaysLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    lazy var sunRiseAndSetTime: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0.8, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textAlignment = .left
        label.text = "일출 / 일몰"
        return label
    }()
    
    
    /// 자외선 지수 - 맨 아래에 구분선
    lazy var bottomLineOfUVRaysFrameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.7)
        return view
    }()
    
    let cellIdentifier = "WeatherCell"
    let numberOfHours = 24
    var currentWeatherData: CustomWeather?
    //    var time = self?.todayCollectionView.topLabel.text
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        todayCollectionView.dataSource = self
        todayCollectionView.delegate = self
        todayCollectionView.register(WeatherCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        setLayout()
        getCurrentWeatherData()
    }

    
    
    func getCurrentWeatherData() {
     
        ECWeather.NetworkService.getCurrentWeather(lat: DataManager.shared.latitude ?? 0, lon: DataManager.shared.longitude ?? 0) { [weak self] (weatherData) in
            if let weatherData = weatherData {
                self?.locationOfCurrentWeatherLabel.text = weatherData.mainDescription
//                self?.currentWeatherImageView.image = weatherData.icon
                self?.currentTemperatuerLabel.text = "\(weatherData.currentTemp)°C"
                self?.currentWeatherLabel.text = weatherData.description
                self?.currentDailyTemperatuerLabel.text = "최고: \(weatherData.maxTemp)°C / 최저: \(weatherData.minTemp)°C"
                
                self?.humidityAndWindStranth.text = "습도: \(weatherData.humidity) / 풍속: \(weatherData.windSpeed)"
                self?.sunRiseAndSetTime.text = "일출시간: \(weatherData.sunrise) / 일몰시간: \(weatherData.sunset)"
                
                cell.topLabel.text = "시간"
                cell.imageView.image = UIImage(named: "WeatherIcon-sun")
                cell.bottomLabel.text = "온도"
                
                
//
               
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
            scrollViewContentView.setCustomSpacing(15, after: currentWeatherFrameView)
            currentWeatherFrameView.setCustomSpacing(15, after: currentWeatherFrameTopLine)
            currentWeatherFrameView.setCustomSpacing(15, after: locationOfCurrentWeatherLabel)
            currentWeatherFrameView.setCustomSpacing(15, after: currentWeatherImageView)
            currentWeatherFrameView.setCustomSpacing(15, after: currentTemperatuerLabel)
            currentWeatherFrameView.setCustomSpacing(15, after: currentWeatherLabel)
            currentWeatherFrameView.setCustomSpacing(15, after: currentDailyTemperatuerLabel)
            currentWeatherFrameView.setCustomSpacing(20, after: currentWeatherFrameBottomLine)
            
            scrollViewContentView.setCustomSpacing(20, after: hourlyWeatherFrameView)
            hourlyWeatherFrameView.setCustomSpacing(20, after: hourlyWeatherFrameTopLine)
            hourlyWeatherFrameView.setCustomSpacing(5, after: hourlyWeatherMentLabel)
            hourlyWeatherFrameView.setCustomSpacing(10, after: underLineOfHourlyWeatherView)
            hourlyWeatherFrameView.setCustomSpacing(10, after: todayCollectionView)
            hourlyWeatherFrameView.setCustomSpacing(20, after: hourlyWeatherFrameBottomLine)
            
            scrollViewContentView.setCustomSpacing(20, after: airQualityFrameView)
            airQualityFrameView.setCustomSpacing(5, after: topLineOfAirQualityFrameView)
            airQualityFrameView.setCustomSpacing(5, after: airQualityNameLabel)
            airQualityFrameView.setCustomSpacing(5, after: bottomLineOfAirQualityLabelView)
            airQualityFrameView.setCustomSpacing(5, after: humidityAndWindStranth)
            airQualityFrameView.setCustomSpacing(20, after: bottomLineOfAirQualityFrameView)
            
            scrollViewContentView.setCustomSpacing(20, after: uvRaysFrameView)
            uvRaysFrameView.setCustomSpacing(5, after: topLineOfUVRaysFrameView)
            uvRaysFrameView.setCustomSpacing(5, after: nameOfUVRaysFrameView)
            uvRaysFrameView.setCustomSpacing(20, after: bottomLineOfUVRaysLabelView)
            uvRaysFrameView.setCustomSpacing(20, after: sunRiseAndSetTime)
            uvRaysFrameView.setCustomSpacing(20, after: bottomLineOfUVRaysFrameView)
            
            
        }
        
        func setBackgroundImageView() {
            view.addSubview(backgroundImageView)
            
            backgroundImageView.snp.makeConstraints {
                $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
            NetworkService.getCurrentWeather(lat: DataManager.shared.latitude!, lon: DataManager.shared.longitude!) { weather in
                var backgroundImage = weather?.mainDescription
                print(backgroundImage)
                switch backgroundImage {
                case BackgroundImage.Clouds.rawValue: self.backgroundImageView.image = BackgroundImage.Clouds.image
                case BackgroundImage.Clear.rawValue: self.backgroundImageView.image = BackgroundImage.Clear.image
                case BackgroundImage.Snow.rawValue: self.backgroundImageView.image = BackgroundImage.Snow.image
                case BackgroundImage.Rain.rawValue: self.backgroundImageView.image = BackgroundImage.Rain.image
                case BackgroundImage.Drizzle.rawValue: self.backgroundImageView.image = BackgroundImage.Drizzle.image
                case BackgroundImage.Thunderstorm.rawValue: self.backgroundImageView.image = BackgroundImage.Thunderstorm.image
                case .none: self.backgroundImageView.image = BackgroundImage.Mist.image
                case .some(_):
                    break
                }
            }
        }
        
        func setScrollViewLayout() {
            backgroundImageView.addSubview(mainScrollView)
            
            mainScrollView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        func setScrollViewContentViewLayout() {
            mainScrollView.addSubview(scrollViewContentView)
            
            scrollViewContentView.snp.makeConstraints {
                $0.edges.equalTo(mainScrollView)
                $0.centerX.equalTo(mainScrollView)
            }
        }
        
        func setMainTitleLayout() {
            scrollViewContentView.addArrangedSubview(mainPageTitleLabel)
            
            mainPageTitleLabel.snp.makeConstraints {
                $0.top.equalTo(scrollViewContentView).offset(10)
                $0.leading.equalTo(scrollViewContentView).offset(20)
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
                //            $0.top.equalTo(currentWeatherFrameView.snp.top)
                $0.leading.equalTo(currentWeatherFrameView).offset(25)
                $0.trailing.equalTo(currentWeatherFrameView).offset(-25)
                $0.height.equalTo(2)
            }
        }
        
        func setCurrentWeatherViewLocationLabelLayout() {
            currentWeatherFrameView.addArrangedSubview(locationOfCurrentWeatherLabel)
            
            //        locationOfCurrentWeatherLabel.snp.makeConstraints {
            //            $0.top.equalTo(currentWeatherFrameTopLine.snp.bottom).offset(20)
            //            $0.leading.equalTo(currentWeatherFrameView).offset(10)
            //            $0.trailing.equalTo(currentWeatherFrameView).offset(-10)
            //        }
        }
        
        func setCurrentWeatherViewIconImageLayout() {
            currentWeatherFrameView.addArrangedSubview(currentWeatherImageView)
            
            currentWeatherImageView.snp.makeConstraints {
                $0.height.equalTo(105)
                $0.top.equalTo(locationOfCurrentWeatherLabel.snp.bottom).offset(10)
                $0.centerX.equalTo(currentWeatherFrameView.snp.centerX)
                //            $0.leading.equalTo(currentWeatherFrameView).offset(10)
                //            $0.trailing.equalTo(currentWeatherFrameView).offset(-10)
            }
        }
        
        func setCurrentWeatherViewTemperatureLabelLayout() {
            currentWeatherFrameView.addArrangedSubview(currentTemperatuerLabel)
            
            currentTemperatuerLabel.snp.makeConstraints {
                //            $0.top.equalTo(currentWeatherImageView.snp.bottom).offset(10)
                $0.leading.equalTo(currentWeatherFrameView).offset(10)
                $0.trailing.equalTo(currentWeatherFrameView).offset(-10)
            }
        }
        
        func setCurrentWeatherViewWeatherLabelLayout() {
            currentWeatherFrameView.addArrangedSubview(currentWeatherLabel)
            
            //        currentWeatherLabel.snp.makeConstraints {
            //            $0.top.equalTo(currentTemperatuerLabel.snp.bottom).offset(10)
            //            $0.leading.equalTo(currentWeatherFrameView).offset(10)
            //            $0.trailing.equalTo(currentWeatherFrameView).offset(-10)
            //        }
        }
        
        func setCurrentWeatherViewDailyTemperatureLabelLayout() {
            currentWeatherFrameView.addArrangedSubview(currentDailyTemperatuerLabel)
            
            //        currentDailyTemperatuerLabel.snp.makeConstraints {
            //            $0.top.equalTo(currentWeatherLabel.snp.bottom).offset(10)
            //            $0.leading.equalTo(currentWeatherFrameView).offset(10)
            //            $0.trailing.equalTo(currentWeatherFrameView).offset(-10)
            //        }
        }
        
        func setCurrentWeatherViewBottomLineLayout() {
            currentWeatherFrameView.addArrangedSubview(currentWeatherFrameBottomLine)
            
            currentWeatherFrameBottomLine.snp.makeConstraints {
                //            $0.top.equalTo(currentDailyTemperatuerLabel.snp.bottom).offset(10)
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
                //            $0.top.equalTo(hourlyWeatherFrameView)
                $0.height.equalTo(2)
                //            $0.leading.equalTo(hourlyWeatherFrameView).offset(10)
                //            $0.trailing.equalTo(hourlyWeatherFrameView).offset(-10)
            }
        }
        
        func setHourlyWeatherViewMentLabelLayout() {
            hourlyWeatherFrameView.addArrangedSubview(hourlyWeatherMentLabel)
            
            hourlyWeatherMentLabel.snp.makeConstraints {
                $0.top.equalTo(hourlyWeatherFrameTopLine.snp.bottom).offset(10)
                $0.leading.equalTo(hourlyWeatherFrameView).offset(5)
                $0.trailing.equalTo(hourlyWeatherFrameView).offset(-5)
            }
        }
        
        func setHourlyWeatherViewMentLabelUnderLineLayout() {
            hourlyWeatherFrameView.addArrangedSubview(underLineOfHourlyWeatherView)
            
            underLineOfHourlyWeatherView.snp.makeConstraints {
                //            $0.top.equalTo(hourlyWeatherMentLabel.snp.bottom)
                $0.height.equalTo(2)
                //            $0.leading.equalTo(hourlyWeatherFrameView).offset(10)
                //            $0.trailing.equalTo(hourlyWeatherFrameView).offset(-10)
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
                //            $0.top.equalTo(todayCollectionView.snp.bottom)
                $0.height.equalTo(2)
                //            $0.bottom.equalTo(hourlyWeatherFrameView)
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
                $0.top.equalTo(topLineOfAirQualityFrameView.snp.bottom).offset(5)
                $0.leading.equalTo(airQualityFrameView).offset(5)
                $0.trailing.equalTo(airQualityFrameView).offset(-5)
            }
        }
        
        func setAirQualityViewUnderLineLayout() {
            airQualityFrameView.addArrangedSubview(bottomLineOfAirQualityLabelView)
            
            bottomLineOfAirQualityLabelView.snp.makeConstraints {
                $0.top.equalTo(airQualityNameLabel.snp.bottom).offset(5)
                $0.height.equalTo(2)
                $0.leading.equalTo(airQualityFrameView).offset(25)
                $0.trailing.equalTo(airQualityFrameView).offset(-25)
            }
        }
    
    func sethumidityAndWindStranthLayout() {
        airQualityFrameView.addArrangedSubview(humidityAndWindStranth)
        
        humidityAndWindStranth.snp.makeConstraints {
            $0.top.equalTo(bottomLineOfAirQualityLabelView.snp.bottom).offset(5)
//            $0.height.equalTo(2)
            $0.leading.equalTo(airQualityFrameView).offset(5)
            $0.trailing.equalTo(airQualityFrameView).offset(-5)
        }
    }
    
        
        func setAirQualityViewBottomLineLayout() {
            airQualityFrameView.addArrangedSubview(bottomLineOfAirQualityFrameView)
            
            bottomLineOfAirQualityFrameView.snp.makeConstraints {
                            $0.top.equalTo(humidityAndWindStranth.snp.bottom)
                $0.height.equalTo(2)
                $0.leading.equalTo(airQualityFrameView).offset(25)
                $0.trailing.equalTo(airQualityFrameView).offset(-25)
                //            $0.bottom.equalTo(airQualityFrameView)
            }
        }
        
        // 네번째 뷰
        func setUVRaysViewLayout() {
            scrollViewContentView.addArrangedSubview(uvRaysFrameView)
            
            uvRaysFrameView.snp.makeConstraints {
                $0.top.equalTo(airQualityFrameView.snp.bottom).offset(20)
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
                $0.top.equalTo(topLineOfUVRaysFrameView.snp.bottom)
                $0.leading.equalTo(uvRaysFrameView).offset(5)
                $0.trailing.equalTo(uvRaysFrameView).offset(-5)
            }
        }
        
        func setUVRaysViewUnderLineLayout() {
            uvRaysFrameView.addArrangedSubview(bottomLineOfUVRaysLabelView)
            
            bottomLineOfUVRaysLabelView.snp.makeConstraints {
                //            $0.top.equalTo(nameOfUVRaysFrameView.snp.bottom)
                $0.height.equalTo(2)
                $0.leading.equalTo(uvRaysFrameView).offset(25)
                $0.trailing.equalTo(uvRaysFrameView).offset(-25)
            }
        }
    
    func setSunRiseAndSetTimeLayout(){
        uvRaysFrameView.addArrangedSubview(sunRiseAndSetTime)
        
        sunRiseAndSetTime.snp.makeConstraints {
                        $0.top.equalTo(bottomLineOfUVRaysLabelView.snp.bottom)
//            $0.height.equalTo(2)
            $0.leading.equalTo(uvRaysFrameView).offset(5)
            $0.trailing.equalTo(uvRaysFrameView).offset(-5)
        }
    }
    
        
        func setUVRaysViewBottomLineLayout() {
            uvRaysFrameView.addArrangedSubview(bottomLineOfUVRaysFrameView)
            
            bottomLineOfUVRaysFrameView.snp.makeConstraints {
                //            $0.top.equalTo(bottomLineOfUVRaysLabelView.snp.bottom)
                $0.height.equalTo(2)
                $0.leading.equalTo(uvRaysFrameView).offset(25)
                $0.trailing.equalTo(uvRaysFrameView).offset(-25)
                //            $0.bottom.equalTo(uvRaysFrameView)
            }
        }
        
        
        
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
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
    }
    
    
    
    class WeatherCell: UICollectionViewCell {
        lazy var verticalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            return stackView
        }()
        
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
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
            imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
    

