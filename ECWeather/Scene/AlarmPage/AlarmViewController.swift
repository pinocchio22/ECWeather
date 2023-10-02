//
//  AlarmViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

// TODO: - 1. 테스트버튼으로 알림 받던것 -> 설정한 시간 요일에 따라 알림 울리도록
// TODO: - 2. 알림 울리는 시간/요일 정보를 앱 내 저장 필요.. (UserDefaults?)
// TODO: - 3. 날씨에 따른 알림 메세지 문구 설정 필요.. (API 반환 값 확인)
// TODO: - 4. 알림 울릴 API 요청할 기준 도시는 어떻게? -> 이것도 앱내 따로 저장 필요..
// TODO: - 5. AVFoundation으로 알림음 연결

import AVFoundation
import SnapKit
import UIKit
import UserNotifications

class AlarmViewController: BaseViewController {
    
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
    
    private let tableViewLabel1: UILabel = {
        let label = UILabel()
        label.text = "사운드"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    private let tableView1: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.separatorInset.left = 0
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let tableViewLabel2: UILabel = {
        let label = UILabel()
        label.text = "알림 내용 선택"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    private let tableView2: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.separatorInset.left = 0
        tableView.separatorStyle = .none
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
        navigationController?.isNavigationBarHidden = false
        tableView1.register(AlarmTableViewCell.self, forCellReuseIdentifier: "AlarmTableViewCell")
        tableView2.register(AlarmTableViewCell.self, forCellReuseIdentifier: "AlarmTableViewCell")

        
        makeWeekdaysBtnStack()
        configureTableView()
        view.addSubview(titleLabel)
        view.addSubview(btnForTest) // !!BUTTON FOR TEST - 나중에 삭제
        view.addSubview(notificationSwitch)
        view.addSubview(descriptionLabel)
        view.addSubview(timePicker)
        view.addSubview(weekdaysBtnLabel)
        view.addSubview(weekdaysBtnStack)
        view.addSubview(tableViewLabel1)
        view.addSubview(tableView1)
        view.addSubview(tableViewLabel2)
        view.addSubview(tableView2)
        
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
        
        tableViewLabel1.snp.makeConstraints {
            $0.top.equalTo(weekdaysBtnStack.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(30)
        }
        
        tableView1.snp.makeConstraints {
            $0.top.equalTo(tableViewLabel1.snp.bottom).offset(10)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        tableViewLabel2.snp.makeConstraints {
            $0.top.equalTo(tableView1.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(30)
        }
        
        tableView2.snp.makeConstraints {
            $0.top.equalTo(tableViewLabel2.snp.bottom).offset(10)
            $0.height.equalTo(100)
            $0.leading.trailing.equalToSuperview().inset(20)
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
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView2.dataSource = self
        tableView2.delegate = self
        
        tableView1.layer.cornerRadius = 10.0
        tableView1.clipsToBounds = true
        tableView2.layer.cornerRadius = 10.0
        tableView2.clipsToBounds = true
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
        }
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            timePicker.isEnabled = true
            descriptionLabel.text = "아래 지정된 시간에 날씨 정보 알림이 전송 됩니다.\n정보는 사용자 위치를 기준으로 제공 됩니다."
            weekdaysBtnLabel.textColor = .ECWeatherColor3
            tableViewLabel1.textColor = .ECWeatherColor3
            tableViewLabel2.textColor = .ECWeatherColor3
            tempColorForSwitch = UIColor(red: 0.00, green: 0.80, blue: 1.00, alpha: 1.00)
            tableView1.reloadData()
            tableView2.reloadData()
        } else {
            timePicker.isEnabled = false
            descriptionLabel.text = "현재 알림이 꺼져 있습니다.\n"
            weekdaysBtnLabel.textColor = .systemGray4
            tableViewLabel1.textColor = .systemGray4
            tableViewLabel2.textColor = .systemGray4
            tempColorForSwitch = .systemGray4

            tableView1.reloadData()
            tableView2.reloadData()
        
        }
    }

}

// MARK: - TableView
extension AlarmViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return 1
        } else if tableView == tableView2 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
            cell.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
            cell.tintColor = tempColorForSwitch
            cell.leadingLabel.text = "알림 수신음"
            cell.traillingLabel.text = "꽥"
            return cell
        } else if tableView == tableView2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
            cell.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
            cell.tintColor = tempColorForSwitch
            
            if indexPath.row == 0 {
                cell.leadingLabel.text = "날씨" // 현재 밖에 날씨는 ~~(맑음)입니다
                cell.traillingImage.isHidden = true
                
                let underline = CALayer()
                underline.frame = CGRect(x: 0, y: cell.frame.height - 1, width: cell.frame.width, height: 1)
                underline.backgroundColor = UIColor.systemGray5.cgColor
                cell.layer.addSublayer(underline)
            } else if indexPath.row == 1 {
                cell.leadingLabel.text = "온도" // 현재 밖에 날씨는 ~~(18)도이고 체감온도는 ~~(25)입니다.
                cell.traillingImage.isHidden = true
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == tableView1 {
            if notificationSwitch.isOn {
                self.navigationController?.pushViewController(SelectNotificationSoundViewController(), animated: true)
            }
        } else if tableView == tableView2 {
            if notificationSwitch.isOn {
                if let cell = tableView.cellForRow(at: indexPath) {
                    cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
                }
            }
        }
    }
}

