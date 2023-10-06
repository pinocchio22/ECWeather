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

import Alamofire
import Foundation
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

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주간 날씨"
        label.textColor = .ECWeatherColor3
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    struct WeatherData {
        var day: String
        let weather: String
        let highTemperature: Int
        let lowTemperature: Int
        let weatherImageName: String
    }

    var selectedCellIndex: IndexPath?

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

//
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

    var weeklyWeatherData: [CustomWeeklyWeather] = []

    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.ECWeatherColor3
        view.addSubview(tableView)
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeeklyTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        getWeeklyWeatherData()
        initRefresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeeklyWeatherData()
    }

    // MARK: - Data Processing

    lazy var weeklyForecast: [WeatherData] = [
        WeatherData(day: "오늘", weather: "맑음", highTemperature: 28, lowTemperature: 15, weatherImageName: "WeatherIcon-sun"),
        WeatherData(day: "내일", weather: "흐림", highTemperature: 24, lowTemperature: 17, weatherImageName: "WeatherIcon-cloudy"),
        WeatherData(day: "월요일", weather: "비", highTemperature: 20, lowTemperature: 14, weatherImageName: "WeatherIcon-rain"),
        WeatherData(day: "화요일", weather: "국지적 흐림", highTemperature: 27, lowTemperature: 18, weatherImageName: "WeatherIcon-cloudy"),
        WeatherData(day: "수요일", weather: "쨍쨍", highTemperature: 30, lowTemperature: 19, weatherImageName: "WeatherIcon-sun"),
        WeatherData(day: "목요일", weather: "비", highTemperature: 21, lowTemperature: 15, weatherImageName: "WeatherIcon-rain"),
        WeatherData(day: "금요일", weather: "쨍쨍", highTemperature: 29, lowTemperature: 16, weatherImageName: "WeatherIcon-sun")
    ]

    // 영어 요일을 한국어로 변환하는 함수
    func convertToKoreanDay(englishDay: String) -> String {
        switch englishDay {
        case "Monday":
            return "월요일"
        case "Tuesday":
            return "화요일"
        case "Wednesday":
            return "수요일"
        case "Thursday":
            return "목요일"
        case "Friday":
            return "금요일"
        case "Saturday":
            return "토요일"
        case "Sunday":
            return "일요일"
        default:
            return englishDay // 다른 요일은 그대로 반환
        }
    }

    func updateWeatherData() {
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: Date())

        for (index, var weatherData) in weeklyForecast.enumerated() {
            if index == 0 {
                weatherData.day = "오늘"
            } else if index == 1 {
                weatherData.day = "내일"
            } else {
                let dayOfWeek = (today + index - 1) % 7
                let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
                weatherData.day = weekdays[dayOfWeek]
            }
            weeklyForecast[index] = weatherData
        }
    }

    func getWeeklyWeatherData() {
        ECWeather.NetworkService.getWeeklyWeather(lat: DataManager.shared.latitude ?? 0, lon: DataManager.shared.longitude ?? 0) { [weak self] weatherData in
            if let weatherData = weatherData {
                self?.weeklyWeatherData = weatherData
                self?.tableView.reloadData()
            } else {
                print("주간 날씨 데이터를 가져오는 데 실패했습니다.")
            }
        }
    }

    // MARK: - Table View Delegate and Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeatherData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeeklyTableViewCell
        let weatherData = weeklyWeatherData[indexPath.row]

        // API에서 가져온 날짜 데이터를 한국어로 변환하여 사용
        let koreanDay = convertToKoreanDay(englishDay: (weatherData.dateTime.toDate()?.toWeekString())!)
        cell.configure(day: koreanDay, weather: weatherData.description, highTemperature: Int(weatherData.maxTemp), lowTemperature: Int(weatherData.minTemp), weatherImageName: weatherData.icon)

        if selectedCellIndex == indexPath {
            cell.selectionStyle = .none
        } else {
            cell.selectionStyle = .default
        }
        return cell
    }

    func getLocalizedDayLabel(for day: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let today = dateFormatter.string(from: Date())

        switch day {
        case today:
            return "오늘"
        case Calendar.current.date(byAdding: .day, value: 1, to: Date()).map { dateFormatter.string(from: $0) } ?? "":
            return "내일"
        default:
            return day
        }
    }

    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        refreshControl.tintColor = .ECWeatherColor3
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")

        tableView.refreshControl = refreshControl
    }

    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침 시작")
        getWeeklyWeatherData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            refresh.endRefreshing()
        }
    }
}

class WeeklyTableViewCell: UITableViewCell {
    let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.ECWeatherColor2
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
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
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            dayLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),

            weatherImageView.topAnchor.constraint(equalTo: topAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),

            weatherLabel.topAnchor.constraint(equalTo: topAnchor),
            weatherLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
            weatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),

            temperatureLabel.topAnchor.constraint(equalTo: topAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: weatherLabel.trailingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
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
        NetworkService.getIcon(iconCode: weatherImageName) { icon in
            DispatchQueue.main.async {
                self.weatherImageView.image = UIImage(data: icon ?? Data())
            }
        }
    }
}
