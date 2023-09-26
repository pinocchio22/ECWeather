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
    
    
    let weeklyForecast = [
        ("Monday", "Sunny"),
        ("Tuesday", "Cloudy"),
        ("Wednesday", "Rainy"),
        ("Thursday", "Partly Cloudy"),
        ("Friday", "Sunny"),
        ("Saturday", "Rainy"),
        ("Sunday", "Sunny")
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let (day, weather) = weeklyForecast[indexPath.row]
        cell.textLabel?.text = "\(day): \(weather)"
        
        return cell
    }
}
