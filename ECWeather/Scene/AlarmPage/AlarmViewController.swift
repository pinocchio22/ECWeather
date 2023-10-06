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

class AlarmViewController: BaseViewController {
    // MARK: - Properties
    
    private var weatherCellStatus: Bool? = nil
    private var temperatureCellStatus: Bool? = nil
    
    private let weekdays: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    private var selectedWeekdays: [Int] = []
    
    private var maxTemp: Int = 0
    private var minTemp: Int = 0
    private var currentWeather: String = ""
    
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
    
    // !!BUTTON FOR PRESENTATION - 나중에 삭제
    private lazy var btnForPresentation: UIButton = {
        let button = UIButton()
        button.setTitle("[시연용 버튼]", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .gray.withAlphaComponent(0.3)
        button.addTarget(self, action: #selector(presentationBtnTapped), for: .touchUpInside)
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
        pickerView.locale = Locale.current
        pickerView.timeZone = TimeZone.current
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
        pickerView.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
        return pickerView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        return contentView
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
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.1
        return stackView
    }()
    
    private let soundMenuTableLabel: UILabel = {
        let label = UILabel()
        label.text = "사운드"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    private let soundMenuTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.separatorInset.left = 0
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let notificationContentTableLabel: UILabel = {
        let label = UILabel()
        label.text = "알림 내용 선택"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    private let notificationContentTable: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.separatorInset.left = 0
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        soundMenuTable.reloadData()
        getCurrentWeatherInfo()
        loadDataFromUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { _, _ in })
    }
    
    private func loadDataFromUserDefaults() {
        // switch on/off 값
        if let switchStatus = UserDefaults.standard.value(forKey: "notificationSwitchStatus") as? Bool {
            notificationSwitch.isOn = switchStatus
        }
        // 타임피커 값
        if let selectedTime = UserDefaults.standard.object(forKey: "timePickerValue") as? Date {
            timePicker.date = selectedTime
        } else {
            timePicker.date = Date()
        }
        
        // 요일별 알림 값
        if let savedSelectedWeekdays = UserDefaults.standard.array(forKey: "selectedWeekdaysKey") as? [Int] {
            selectedWeekdays = savedSelectedWeekdays
            print("요일별 알림: ", selectedWeekdays)
            for (index, button) in weekdaysBtnStack.arrangedSubviews.enumerated() {
                if let button = button as? UIButton {
                    if selectedWeekdays.contains(index) {
                        button.backgroundColor = .ECWeatherColor3?.withAlphaComponent(0.5)
                    } else {
                        button.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
                    }
                }
            }
        }
        
        // 알림 내용 선택 값
        weatherCellStatus = UserDefaults.standard.bool(forKey: "weatherCellSelectedKey")
        temperatureCellStatus = UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey")
    }

    // MARK: - Methods & Selectors

    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        soundMenuTable.register(AlarmTableViewCell.self, forCellReuseIdentifier: "AlarmTableViewCell")
        notificationContentTable.register(AlarmTableViewCell.self, forCellReuseIdentifier: "AlarmTableViewCell")

        makeWeekdaysBtnStack()
        configureTableView()
        view.addSubview(titleLabel)
        view.addSubview(btnForPresentation) // !!BUTTON FOR PRESENTATION - 나중에 삭제
        view.addSubview(notificationSwitch)
        view.addSubview(descriptionLabel)
        view.addSubview(timePicker)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(weekdaysBtnLabel)
        contentView.addSubview(weekdaysBtnStack)
        contentView.addSubview(soundMenuTableLabel)
        contentView.addSubview(soundMenuTable)
        contentView.addSubview(notificationContentTableLabel)
        contentView.addSubview(notificationContentTable)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(25)
        }
        
        // !!BUTTON FOR PRESENTATION
        btnForPresentation.snp.makeConstraints {
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
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(25)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView)
        }
        
        weekdaysBtnLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        weekdaysBtnStack.snp.makeConstraints {
            $0.top.equalTo(weekdaysBtnLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(35)
        }
        
        soundMenuTableLabel.snp.makeConstraints {
            $0.top.equalTo(weekdaysBtnStack.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        soundMenuTable.snp.makeConstraints {
            $0.top.equalTo(soundMenuTableLabel.snp.bottom).offset(10)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        notificationContentTableLabel.snp.makeConstraints {
            $0.top.equalTo(soundMenuTable.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        notificationContentTable.snp.makeConstraints {
            $0.top.equalTo(notificationContentTableLabel.snp.bottom).offset(10)
            $0.height.equalTo(100)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
    
    private func makeWeekdaysBtnStack() {
        for day in weekdays {
            let button = UIButton(type: .custom)
            button.setTitle(day, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
            button.addTarget(self, action: #selector(weekdaysButtonTapped), for: .touchUpInside)
            
            button.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            
            weekdaysBtnStack.addArrangedSubview(button)
        }
    }
    
    private func configureTableView() {
        soundMenuTable.dataSource = self
        soundMenuTable.delegate = self
        notificationContentTable.dataSource = self
        notificationContentTable.delegate = self
        
        soundMenuTable.layer.cornerRadius = 10.0
        soundMenuTable.clipsToBounds = true
        notificationContentTable.layer.cornerRadius = 10.0
        notificationContentTable.clipsToBounds = true
    }
    
    private func getCurrentWeatherInfo() {
        NetworkService.getCurrentWeather(lat: DataManager.shared.latitude!, lon: DataManager.shared.longitude!) { item in
            if let item = item {
                self.maxTemp = Int(item.maxTemp)
                self.minTemp = Int(item.minTemp)
                self.currentWeather = item.description
            }
        }
    }
    
    // !!BUTTON FOR PRESENTATION - 나중에 삭제
    @objc private func presentationBtnTapped() {
        let content = UNMutableNotificationContent()
        content.title = "ECWeather - 날씨 알리미"
        
        // "날씨","온도" 둘다 미체크.. TODO: - 애초에 사용자가 둘다 체크해제 못하게 막아야함
        content.body =
            """
            알림내용 체크 안되어 있음..
            """
        
        // "날씨" 체크
        if UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") && !UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") {
            content.body =
                """
                현재 날씨는 \(currentWeather)입니다.
                """
        }
        
        // "온도" 체크
        else if UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") && !UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") {
            if DataManager.shared.temperatureType.rawValue == "units=imperial" {
                content.body =
                    """
                    오늘의 최저기온은 \(minTemp)°F 이며,
                    최고기온은 \(maxTemp)°F 까지 오를 예정입니다.
                    """
            } else {
                content.body =
                    """
                    오늘의 최저기온은 \(minTemp)°C 이며,
                    최고기온은 \(maxTemp)°C 까지 오를 예정입니다.
                    """
            }
        }
        
        // "날씨", "온도" 체크
        else if UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") && UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") {
            if DataManager.shared.temperatureType.rawValue == "units=imperial" {
                content.body =
                    """
                    현재 날씨는 \(currentWeather)입니다.
                    (\(minTemp)°F - \(maxTemp)°F)
                    """
            } else {
                content.body =
                    """
                    현재 날씨는 \(currentWeather)입니다.
                    (\(minTemp)°C - \(maxTemp)°C)
                    """
            }
        }
        
        if let selectedSoundName = UserDefaults.standard.value(forKey: "SelectedFileName") as? String {
            content.sound = UNNotificationSound(named: UNNotificationSoundName("\(selectedSoundName).caf"))
        } else {
            content.sound = UNNotificationSound.default
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "weather", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    private func scheduleNotification() {
        // 모든 대기열에 있는 알림을 삭제
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        let selectedDate = timePicker.date

        // 메세지 내용
        let content = UNMutableNotificationContent()
        content.title = "ECWeather - 날씨 알리미"
        
        content.body =
            """
            알림내용 체크 안되어 있음..
            """
        
        // "날씨" 체크
        if UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") && !UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") {
            content.body =
                """
                현재 날씨는 \(currentWeather)입니다.
                """
        }
        
        // "온도" 체크
        else if UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") && !UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") {
            if DataManager.shared.temperatureType.rawValue == "units=imperial" {
                content.body =
                    """
                    오늘의 최저기온은 \(minTemp)°F 이며,
                    최고기온은 \(maxTemp)°F 까지 오를 예정입니다.
                    """
            } else {
                content.body =
                    """
                    오늘의 최저기온은 \(minTemp)°C 이며,
                    최고기온은 \(maxTemp)°C 까지 오를 예정입니다.
                    """
            }
        }
        
        // "날씨", "온도" 체크
        else if UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") && UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") {
            if DataManager.shared.temperatureType.rawValue == "units=imperial" {
                content.body =
                    """
                    현재 날씨는 \(currentWeather)입니다.
                    (\(minTemp)°F - \(maxTemp)°F)
                    """
            } else {
                content.body =
                    """
                    현재 날씨는 \(currentWeather)입니다.
                    (\(minTemp)°C - \(maxTemp)°C)
                    """
            }
        }
            
        if let selectedSoundName = UserDefaults.standard.value(forKey: "SelectedFileName") as? String {
            content.sound = UNNotificationSound(named: UNNotificationSoundName("\(selectedSoundName).caf"))
        } else {
            content.sound = UNNotificationSound.default
        }
        
        // 요일과 시간대 설정
        let calendar = Calendar.current
        let selectedHour = calendar.component(.hour, from: selectedDate)
        let selectedMinute = calendar.component(.minute, from: selectedDate)
        
        var dateComponents = DateComponents()
        dateComponents.calendar = calendar

        for weekday in selectedWeekdays {
            dateComponents.weekday = weekday + 1
            dateComponents.hour = selectedHour
            dateComponents.minute = selectedMinute
            
            // UNCalendarNotificationTrigger : 특정 요일과 시간대에 알림 스케줄
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // 알림 요청 생성
            let randomIdentifier = UUID().uuidString
            let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    @objc private func weekdaysButtonTapped(sender: UIButton) {
        if notificationSwitch.isOn {
            if sender.backgroundColor == .ECWeatherColor4?.withAlphaComponent(0.3) {
                sender.backgroundColor = .ECWeatherColor3?.withAlphaComponent(0.5)
                if let title = sender.currentTitle {
                    if let weekdaysIndex = weekdays.firstIndex(of: title) {
                        selectedWeekdays.append(weekdaysIndex)
                        UserDefaults.standard.set(selectedWeekdays, forKey: "selectedWeekdaysKey")
                        scheduleNotification()
                    }
                }
            } else {
                sender.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
                if let title = sender.currentTitle {
                    if let weekdaysIndex = weekdays.firstIndex(of: title) {
                        if selectedWeekdays.contains(weekdaysIndex) {
                            if let index = selectedWeekdays.firstIndex(of: weekdaysIndex) {
                                selectedWeekdays.remove(at: index)
                                UserDefaults.standard.set(selectedWeekdays, forKey: "selectedWeekdaysKey")
                                scheduleNotification()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            timePicker.isEnabled = true
            descriptionLabel.text = "아래 지정된 시간에 날씨 정보 알림이 전송 됩니다.\n정보는 사용자 위치를 기준으로 제공 됩니다."
            weekdaysBtnLabel.textColor = .ECWeatherColor3
            soundMenuTableLabel.textColor = .ECWeatherColor3
            notificationContentTableLabel.textColor = .ECWeatherColor3
            tempColorForSwitch = UIColor(red: 0.00, green: 0.80, blue: 1.00, alpha: 1.00)
            soundMenuTable.reloadData()
            notificationContentTable.reloadData()
            
            UserDefaults.standard.set(true, forKey: "notificationSwitchStatus")
            scheduleNotification()
        } else {
            timePicker.isEnabled = false
            descriptionLabel.text = "현재 알림이 꺼져 있습니다.\n"
            weekdaysBtnLabel.textColor = .systemGray4
            soundMenuTableLabel.textColor = .systemGray4
            notificationContentTableLabel.textColor = .systemGray4
            tempColorForSwitch = .systemGray4
            soundMenuTable.reloadData()
            notificationContentTable.reloadData()
            
            UserDefaults.standard.set(false, forKey: "notificationSwitchStatus")
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 모든 대기열에 있는 알림을 삭제
        }
    }
    
    @objc private func timePickerValueChanged() {
        UserDefaults.standard.set(timePicker.date, forKey: "timePickerValue")
        scheduleNotification()
    }
}

// MARK: - TableView 알림페이지 메뉴 테이블

extension AlarmViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == soundMenuTable {
            return 1
        } else if tableView == notificationContentTable {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == soundMenuTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
            cell.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
            cell.tintColor = tempColorForSwitch
            cell.leadingLabel.text = "알림 수신음"
            if let selectedCellIndex = UserDefaults.standard.value(forKey: "SelectedCellIndex") as? Int {
                let soundNames = Array(DataManager.notificationSoundList.keys).sorted()
                let selectedSoundName = soundNames[selectedCellIndex]
                cell.traillingLabel.text = selectedSoundName
            } else {
                cell.traillingLabel.text = ""
            }
            return cell
        } else if tableView == notificationContentTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
            cell.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
            cell.tintColor = tempColorForSwitch
            
            if indexPath.row == 0 {
                cell.leadingLabel.text = "날씨"
                cell.traillingImage.isHidden = true
                
                let underline = CALayer()
                underline.frame = CGRect(x: 0, y: cell.frame.height - 1, width: cell.frame.width, height: 1)
                underline.backgroundColor = UIColor.systemGray5.cgColor
                if let weatherCellStatus = weatherCellStatus {
                    cell.accessoryType = weatherCellStatus ? .checkmark : .none
                } else {
                    cell.accessoryType = .none
                }
                cell.layer.addSublayer(underline)
            } else if indexPath.row == 1 {
                cell.leadingLabel.text = "온도"
                if let temperatureCellStatus = temperatureCellStatus {
                    cell.accessoryType = temperatureCellStatus ? .checkmark : .none
                } else {
                    cell.accessoryType = .none
                }
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
        
        if tableView == soundMenuTable {
            if notificationSwitch.isOn {
                navigationController?.pushViewController(SelectNotificationSoundViewController(), animated: true)
            }
        } else if tableView == notificationContentTable {
            if notificationSwitch.isOn {
                if let cell = tableView.cellForRow(at: indexPath) {
                    if indexPath.row == 0 {
                        // 날씨
                        if cell.accessoryType == .checkmark {
                            if let weatherStatus = weatherCellStatus, let temperatureStatus = temperatureCellStatus {
                                if weatherStatus && temperatureStatus {
                                    cell.accessoryType = .none
                                    UserDefaults.standard.set(false, forKey: "weatherCellSelectedKey")
                                    weatherCellStatus = !(weatherCellStatus ?? true)
                                    scheduleNotification()
                                }
                            }
                        } else {
                            cell.accessoryType = .checkmark
                            UserDefaults.standard.set(true, forKey: "weatherCellSelectedKey")
                            weatherCellStatus = !(weatherCellStatus ?? false)
                            scheduleNotification()
                        }
                    } else if indexPath.row == 1 {
                        // 온도
                        if cell.accessoryType == .checkmark {
                            if let weatherStatus = weatherCellStatus, let temperatureStatus = temperatureCellStatus {
                                if weatherStatus && temperatureStatus {
                                    cell.accessoryType = .none
                                    UserDefaults.standard.set(false, forKey: "temperatureCellSelectedKey")
                                    temperatureCellStatus = !(temperatureCellStatus ?? true)
                                    scheduleNotification()
                                }
                            }
                        } else {
                            cell.accessoryType = .checkmark
                            UserDefaults.standard.set(true, forKey: "temperatureCellSelectedKey")
                            temperatureCellStatus = !(temperatureCellStatus ?? false)
                            scheduleNotification()
                        }
                    }
                }
            }
        }
    }
}
