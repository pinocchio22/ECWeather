//
//  WeeklyViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

//import UIKit
//
//class WeeklyViewController: UIViewController {
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
//}


import UIKit

class WeeklyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    struct WeatherData {
        let day: String
        let weather: String
        let highTemperature: Int
        let lowTemperature: Int
    }
    
    let weeklyForecast: [WeatherData] = [
        WeatherData(day: "월요일", weather: "맑음", highTemperature: 28, lowTemperature: 15),
        WeatherData(day: "화요일", weather: "흐림", highTemperature: 24, lowTemperature: 17),
        WeatherData(day: "수요일", weather: "비", highTemperature: 20, lowTemperature: 14),
        WeatherData(day: "목요일", weather: "국지적 흐림", highTemperature: 27, lowTemperature: 18),
        WeatherData(day: "금요일", weather: "쨍쨍", highTemperature: 30, lowTemperature: 19),
        WeatherData(day: "토요일", weather: "비", highTemperature: 21, lowTemperature: 15),
        WeatherData(day: "일요일", weather: "쨍쨍", highTemperature: 29, lowTemperature: 16)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeeklyTableViewCell
        
        let weatherData = weeklyForecast[indexPath.row]
        cell.configure(day: weatherData.day, weather: weatherData.weather, highTemperature: weatherData.highTemperature, lowTemperature: weatherData.lowTemperature)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalSpacingHeight = 16 * 2
        let cellSpacing = 8
        let cellHeight = 50
        return CGFloat(cellHeight + cellSpacing + totalSpacingHeight)
    }
}

class WeeklyTableViewCell: UITableViewCell {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dayLabel)
        addSubview(weatherLabel)
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            weatherLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 16),
            weatherLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
            
            temperatureLabel.leadingAnchor.constraint(equalTo: weatherLabel.trailingAnchor, constant: 16),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            temperatureLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(day: String, weather: String, highTemperature: Int, lowTemperature: Int) {
        dayLabel.text = day
        weatherLabel.text = weather
        temperatureLabel.text = "\(highTemperature)° / \(lowTemperature)°"
    }
}
