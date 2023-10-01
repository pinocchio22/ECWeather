//
//  SettingViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import UIKit
import SnapKit

class SettingViewController: BaseViewController {
    
    /// 설정 title label
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.textColor = .ECWeatherColor3
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    /// main table view
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
        view.addSubview(titleLabel)
        view.addSubview(mainTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
        cell.segmentedControl.isHidden = indexPath.row != 0
        cell.segmentedControl.tag = indexPath.row
        cell.segmentedControl.addTarget(self, action: #selector(cell.didChangeValueSegement(segment:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let vc = SearchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
