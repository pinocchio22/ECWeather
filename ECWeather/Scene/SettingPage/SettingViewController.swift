//
//  SettingViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    lazy var mainTableView: UITableView = {
        let tableview = UITableView()
        tableview.layer.cornerRadius = 10
        return tableview
    }()
    
    let items: [String] = ["단위 변환", "현재 위치 재설정", "지역 추가"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableview()
        setLayout()
    }
    
    func registerTableview() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
    }
    
    func setLayout() {
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        view.addSubview(titleLabel)
        view.addSubview(mainTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view).offset(78)
            $0.leading.equalTo(view).offset(34)
        }
        
        mainTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp_bottomMargin).offset(30)
            $0.leading.equalTo(view).offset(20)
            $0.trailing.equalTo(view).offset(-20)
            $0.bottom.equalTo(view)
        }
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = items[indexPath.row]
        return cell
    }
}
