//
//  AlarmViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import AVFoundation
import SnapKit
import UIKit
import UserNotifications

class AlarmViewController: UIViewController {
    
    // MARK: - Properties
    private let weekdays: [String] = ["일","월","화","수","목","금","토"]
    private var tempColorForSwitch: UIColor? = UIColor(red: 0.00, green: 0.80, blue: 1.00, alpha: 1.00)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "날씨 알림"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 지정된 시간에 날씨 정보 알림이 전송 됩니다.\n정보는 사용자 위치를 기준으로 제공 됩니다."
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    // !!BUTTON FOR TEST - 나중에 삭제
    private lazy var btnForTest: UIButton = {
        let button = UIButton()
        button.setTitle("[테스트]", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .gray.withAlphaComponent(0.3)
        button.addTarget(self, action: #selector(testBtnTapped), for: .touchUpInside)
        button.bounds = CGRect(x: 0, y: 0, width: 20, height: 20) // TODO: - 원형 만들기
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        return button
    }()
    
    private lazy var notificationSwitch: UISwitch = {
        let notificationSwitch = UISwitch()
        notificationSwitch.isOn = true
        notificationSwitch.onTintColor = .ECWeatherColor3
        notificationSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return notificationSwitch
    }()
    
    private let timePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .time
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "en_US")
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
        return pickerView
    }()

    private let weekdaysBtnLabel: UILabel = {
        let label = UILabel()
        label.text = "요일별 알림"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    private let weekdaysBtnStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound], completionHandler: {didAllow,Error in })

    }

    // MARK: - Methods & Selectors
    private func configureUI() {
        view.backgroundColor = .white
        tableView.register(SelectNotificationSoundCell.self, forCellReuseIdentifier: "SelectNotificationSoundCell")

        
        makeWeekdaysBtnStack()
        configureTableView()
        view.addSubview(titleLabel)
        view.addSubview(btnForTest) // !!BUTTON FOR TEST - 나중에 삭제
        view.addSubview(notificationSwitch)
        view.addSubview(descriptionLabel)
        view.addSubview(timePicker)
        view.addSubview(weekdaysBtnLabel)
        view.addSubview(weekdaysBtnStack)
        view.addSubview(tableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(25)
        }
        
        // !!BUTTON FOR TEST - 나중에 삭제
        btnForTest.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(notificationSwitch.snp.leading).offset(-15)
        }
        
        notificationSwitch.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-35)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
        }
        
        timePicker.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-100)
        }
        
        weekdaysBtnLabel.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(30)
        }
        
        weekdaysBtnStack.snp.makeConstraints {
            $0.top.equalTo(weekdaysBtnLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(weekdaysBtnStack.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func makeWeekdaysBtnStack() {
        for day in weekdays {
            let button = UIButton(type: .custom)
            button.setTitle(day, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
            button.addTarget(self, action: #selector(weekdaysButtonTapped), for: .touchUpInside)
            
            button.bounds = CGRect(x: 0, y: 0, width: 20, height: 20) // TODO: - 원형 만들기
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            
            weekdaysBtnStack.addArrangedSubview(button)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.isScrollEnabled = false
//        tableView.separatorStyle = .singleLine
    }
    
    // !!BUTTON FOR TEST - 나중에 삭제
    @objc private func testBtnTapped() {
        let content = UNMutableNotificationContent()
        
        content.title = "e편한날씨 - 날씨 알리미"
        content.body = 
        """
        현재 밖의 날씨는 ☀️(맑음)입니다.
        집 밖에 좀 나가십쇼.
        """
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
        let request = UNNotificationRequest(identifier: "weather", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    @objc private func weekdaysButtonTapped(sender: UIButton) {
        if notificationSwitch.isOn {
            if sender.backgroundColor == .ECWeatherColor4?.withAlphaComponent(0.3) {
                sender.backgroundColor = .ECWeatherColor3?.withAlphaComponent(0.5)
                // TODO: - 요일 눌렀을때 이벤트 처리
            } else {
                sender.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
            }
        } else {
            sender.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
        }
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            timePicker.isEnabled = true
            descriptionLabel.text = "아래 지정된 시간에 날씨 정보 알림이 전송 됩니다.\n정보는 사용자 위치를 기준으로 제공 됩니다."
            weekdaysBtnLabel.textColor = .ECWeatherColor3
            tempColorForSwitch = UIColor(red: 0.00, green: 0.80, blue: 1.00, alpha: 1.00)
            tableView.reloadData()
        } else {
            timePicker.isEnabled = false
            descriptionLabel.text = "현재 알림이 꺼져 있습니다.\n"
            weekdaysBtnLabel.textColor = .systemGray4
            tempColorForSwitch = .systemGray4
            tableView.reloadData()
           
        }
    }

}

// MARK: - TableView
extension AlarmViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 10)
        headerLabel.textColor = tempColorForSwitch
        headerView.addSubview(headerLabel)
        
        if section == 0 {
            headerLabel.text = "사운드"
        } else if section == 1 {
            headerLabel.text = "알림 내용 선택"
        }

        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectNotificationSoundCell", for: indexPath) as! SelectNotificationSoundCell
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
        cell.tintColor = tempColorForSwitch


        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.leadingLabel.text = "알림 수신음"
                cell.traillingLabel.text = "꽥" // TODO: - 선택한 알림음이 나오도록
//                cell.layer.cornerRadius = 10
//                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.leadingLabel.text = "날씨" // 현재 밖에 날씨는 ~~(맑음)입니다
                cell.traillingImage.isHidden = true
//                cell.layer.cornerRadius = 10
//                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == 1 {
                cell.leadingLabel.text = "온도" // 현재 밖에 날씨는 ~~(18)도이고 체감온도는 ~~(25)입니다.
                cell.traillingImage.isHidden = true
//                cell.layer.cornerRadius = 10
//                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if notificationSwitch.isOn {
            if let cell = tableView.cellForRow(at: indexPath) {
                if indexPath.section == 0 && indexPath.row == 0 {
                    self.navigationController?.pushViewController(SelectNotificationSoundViewController(), animated: true)
                } else if indexPath.section == 1 && indexPath.row == 0 {
                    cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
                } else if indexPath.section == 1 && indexPath.row == 1 {
                    cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
                }
            }
        }
    }
    
}

