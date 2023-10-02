//
//  WeeklyViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

// import UIKit
//
// class WeeklyViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()

// Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
// }
import UIKit

class WeeklyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    struct WeatherData {
        var day: String // 'let' 대신 'var'로 변경
        let weather: String
        let highTemperature: Int
        let lowTemperature: Int
        let weatherImageName: String
    }
    
    var selectedCellIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.ECWeatherColor3
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        // 타이틀을 navigationController를 통해 설정
        self.title = "주간 날씨"
        
        updateWeatherData()
    }
    
    lazy var weeklyForecast: [WeatherData] = [
        WeatherData(day: "오늘", weather: "맑음", highTemperature: 28, lowTemperature: 15, weatherImageName: "WeatherIcon-sun"),
        WeatherData(day: "내일", weather: "흐림", highTemperature: 24, lowTemperature: 17, weatherImageName: "WeatherIcon-cloudy"),
        WeatherData(day: "월요일", weather: "비", highTemperature: 20, lowTemperature: 14, weatherImageName: "WeatherIcon-rain"),
        WeatherData(day: "화요일", weather: "국지적 흐림", highTemperature: 27, lowTemperature: 18, weatherImageName: "WeatherIcon-cloudy"),
        WeatherData(day: "수요일", weather: "쨍쨍", highTemperature: 30, lowTemperature: 19, weatherImageName: "WeatherIcon-sun"),
        WeatherData(day: "목요일", weather: "비", highTemperature: 21, lowTemperature: 15, weatherImageName: "WeatherIcon-rain"),
        WeatherData(day: "금요일", weather: "쨍쨍", highTemperature: 29, lowTemperature: 16, weatherImageName: "WeatherIcon-sun")
    ]
    
    func updateWeatherData() {
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: Date())
        
        for (index, var weatherData) in weeklyForecast.enumerated() { // 'var' 사용
            if index == 0 {
                weatherData.day = "오늘"
            } else if index == 1 {
                weatherData.day = "내일"
            } else {
                let dayOfWeek = (today + index - 1) % 7
                let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
                weatherData.day = weekdays[dayOfWeek]
            }
            weeklyForecast[index] = weatherData // 수정된 weatherData 다시 할당
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeeklyTableViewCell
        let weatherData = weeklyForecast[indexPath.row]
        
        cell.configure(day: weatherData.day, weather: weatherData.weather, highTemperature: weatherData.highTemperature, lowTemperature: weatherData.lowTemperature, weatherImageName: weatherData.weatherImageName)
        
        if selectedCellIndex == indexPath {
            cell.selectionStyle = .none
        } else {
            cell.selectionStyle = .default
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalSpacingHeight = 16 * 2
        let cellSpacing = 8
        let cellHeight = 50
        
        if selectedCellIndex == indexPath {
            return CGFloat(cellHeight + cellSpacing + totalSpacingHeight) * 2.0
        } else {
            return CGFloat(cellHeight + cellSpacing + totalSpacingHeight)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndex == indexPath {
            selectedCellIndex = nil
        } else {
            selectedCellIndex = indexPath
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class WeeklyTableViewCell: UITableViewCell {
    let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.ECWeatherColor2
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.ECWeatherColor3
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.ECWeatherColor2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dayLabel)
        addSubview(weatherImageView)
        addSubview(weatherLabel)
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            weatherImageView.topAnchor.constraint(equalTo: topAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            weatherLabel.topAnchor.constraint(equalTo: topAnchor),
            weatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
            weatherLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: weatherLabel.trailingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(day: String, weather: String, highTemperature: Int, lowTemperature: Int, weatherImageName: String) {
        dayLabel.text = day
        weatherLabel.text = weather
        temperatureLabel.text = "\(highTemperature)° / \(lowTemperature)°"
        weatherImageView.image = UIImage(named: weatherImageName)
    }
}
