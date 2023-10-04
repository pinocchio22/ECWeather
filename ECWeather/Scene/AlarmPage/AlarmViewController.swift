//
//  AlarmViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import AVFoundation
import CoreLocation
import SnapKit
import UIKit
import UserNotifications

class AlarmViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    private var weatherCellStatus: Bool? = nil
    private var temperatureCellStatus: Bool? = nil
    
    private let weekdays: [String] = ["월","화","수","목","금","토","일"]
    private var selectedWeekdays: [Int] = []
    
    private var maxTemp: Double = 0
    private var minTemp: Double = 0
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
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView1.reloadData()
        getCurrentWeatherInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFromUserDefaults()
//        loadLocationInfomation()
        configureUI()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound], completionHandler: {didAllow,Error in })
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
        
        // 알림 수신음 값
        
        // 알림 내용 선택 값
        weatherCellStatus = UserDefaults.standard.bool(forKey: "weatherCellSelectedKey")
        temperatureCellStatus = UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey")

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
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(weekdaysBtnLabel)
        contentView.addSubview(weekdaysBtnStack)
        contentView.addSubview(tableViewLabel1)
        contentView.addSubview(tableView1)
        contentView.addSubview(tableViewLabel2)
        contentView.addSubview(tableView2)
        
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
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(25)
            $0.centerX.leading.trailing.bottom.equalToSuperview()
//            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.centerX.equalTo(scrollView)
            $0.height.equalTo(500)
        }
        
        weekdaysBtnLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.width.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(30)
        }
        
        weekdaysBtnStack.snp.makeConstraints {
            $0.top.equalTo(weekdaysBtnLabel.snp.bottom).offset(10)
//            $0.width.equalToSuperview().offset(-80)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        tableViewLabel1.snp.makeConstraints {
            $0.top.equalTo(weekdaysBtnStack.snp.bottom).offset(25)
            $0.width.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(30)
        }
        
        tableView1.snp.makeConstraints {
            $0.top.equalTo(tableViewLabel1.snp.bottom).offset(10)
            $0.width.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        tableViewLabel2.snp.makeConstraints {
            $0.top.equalTo(tableView1.snp.bottom).offset(25)
            $0.width.equalToSuperview().offset(-50)
            $0.leading.equalToSuperview().offset(30)
        }
        
        tableView2.snp.makeConstraints {
            $0.top.equalTo(tableViewLabel2.snp.bottom).offset(10)
            $0.width.equalToSuperview().offset(-50)
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
    
    private func getCurrentWeatherInfo() {
        NetworkService.getCurrentWeather(lat: DataManager.shared.latitude!, lon: DataManager.shared.longitude!) { item in
            if let item = item {

                // 켈빈에서 섭씨로 변환
                let maxTempKelvinToCelsius = (item.maxTemp - 273.15)
                let minTempKelvinToCelsius = (item.minTemp - 273.15)
                
                // 반올림 (소수점 첫 번째 자리까지)
                self.maxTemp = round(maxTempKelvinToCelsius * 10) / 10
                self.minTemp = round(minTempKelvinToCelsius * 10) / 10
                
                print("현위치 최고온도 : \(self.maxTemp)°C")
                print("현위치 최저온도 : \(self.minTemp)°C")
                
                self.currentWeather = item.descriotion
//                    print("현위치 최저온도 : ", item.minTemp)
//                    print("현위치 최고온도 : ", item.maxTemp)
                print("현위치 날씨 : ", self.currentWeather)
            }
        }
    }
    
    // !!BUTTON FOR TEST - 나중에 삭제
    @objc private func testBtnTapped() {
    
        let content = UNMutableNotificationContent()
        
        content.title = "ECWeather - 날씨 알리미"
        
        // "날씨","온도" 둘다 미체크.. TODO: - 애초에 사용자가 둘다 체크해제 못하게 막아야함
        content.body =
        """
        알림내용 체크 안되어 있음..
        """
        
        print("🧔🏻‍♂️🧔🏻‍♂️ weatherCellSelectedKey : ",UserDefaults.standard.bool(forKey: "weatherCellSelectedKey"))
        print("🧔🏻‍♂️🧔🏻‍♂️ temperatureCellSelectedKey : ",!UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey"))
        // "날씨" 체크
        if UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") && !UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey"){
            print("1111111111들어옴!!!")
            content.body =
            """
            The current weather is \(currentWeather).
            """
        }
        
        // "온도" 체크
        else if UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") && !UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") {
            print("222222들어옴!!!")
            content.body =
            """
            Today's temperature ranges from \(minTemp)°C to \(maxTemp)°C.
            """
            
        }
        
        // "날씨", "온도" 체크
        else if UserDefaults.standard.bool(forKey: "weatherCellSelectedKey") && UserDefaults.standard.bool(forKey: "temperatureCellSelectedKey") {
            print("33333들어옴!!!")
            content.body =
            """
            The current weather is \(currentWeather). 
            (\(minTemp)°C - \(maxTemp)°C)
            """
            
        }
        

        if let selectedSoundName = UserDefaults.standard.value(forKey: "SelectedFileName") as? String {
            content.sound = UNNotificationSound(named: UNNotificationSoundName("\(selectedSoundName).caf"))
        } else {
            content.sound = UNNotificationSound.default
        }


        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
        let request = UNNotificationRequest(identifier: "weather", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    // 타임피커에 저장된 시간에 알림 (나중에 테스트 버튼 대체..)
    private func scheduleNotification() {
        
        // 모든 대기열에 있는 알림을 삭제
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // 시간 불러오기
        let selectedDate = timePicker.date

        print("👏🏼👏🏼👏🏼selectedDate : ",selectedDate)

        // 메세지 내용
        let content = UNMutableNotificationContent()
        content.title = "e편한날씨 - 날씨 알리미"
        content.body =
        """
        타임피커 알림 발송 테스트 입니다..ㅁㄴㅇㅁㄴㅇㅁㄴ!!
        """
            
        
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
        
        print("SELECTED HOUR : ",selectedHour)
        print("SELECTED MINUTE : ",selectedMinute)
        
        for weekday in selectedWeekdays {
            dateComponents.weekday = weekday + 1
            dateComponents.hour = selectedHour
            dateComponents.minute = selectedMinute
            
            print(dateComponents)
            
            // UNCalendarNotificationTrigger : 특정 요일과 시간대에 알림 스케줄
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // 알림 요청 생성
            let randomIdentifier = UUID().uuidString
            let request = UNNotificationRequest(identifier: randomIdentifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("알림 실패: \(error.localizedDescription)")
                } else {
                    print("알림 성공.")
                }
            }
            
        }
        
        // 대기중인 알림 찍어보기
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("대기 중인 알림 개수: \(requests.count)")
        }
        
    }
    
    @objc private func weekdaysButtonTapped(sender: UIButton) {
        if notificationSwitch.isOn {
            if sender.backgroundColor == .ECWeatherColor4?.withAlphaComponent(0.3) {
                sender.backgroundColor = .ECWeatherColor3?.withAlphaComponent(0.5)
                if let title = sender.currentTitle {
                    if let weekdaysIndex = weekdays.firstIndex(of: title) {
                       selectedWeekdays.append(weekdaysIndex)
                       print(selectedWeekdays)
                   }
                }
            } else {
               sender.backgroundColor = .ECWeatherColor4?.withAlphaComponent(0.3)
               if let title = sender.currentTitle {
                   if let weekdaysIndex = weekdays.firstIndex(of: title) {
                       if selectedWeekdays.contains(weekdaysIndex) {
                           if let index = selectedWeekdays.firstIndex(of: weekdaysIndex) {
                               selectedWeekdays.remove(at: index)
                               print(selectedWeekdays)
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
            tableViewLabel1.textColor = .ECWeatherColor3
            tableViewLabel2.textColor = .ECWeatherColor3
            tempColorForSwitch = UIColor(red: 0.00, green: 0.80, blue: 1.00, alpha: 1.00)
            tableView1.reloadData()
            tableView2.reloadData()
            
            UserDefaults.standard.set(true, forKey: "notificationSwitchStatus")
            scheduleNotification()
        } else {
            timePicker.isEnabled = false
            descriptionLabel.text = "현재 알림이 꺼져 있습니다.\n"
            weekdaysBtnLabel.textColor = .systemGray4
            tableViewLabel1.textColor = .systemGray4
            tableViewLabel2.textColor = .systemGray4
            tempColorForSwitch = .systemGray4
            tableView1.reloadData()
            tableView2.reloadData()
            
            UserDefaults.standard.set(false, forKey: "notificationSwitchStatus")
            scheduleNotification()
        
        }
    }
    
    @objc private func timePickerValueChanged() {
        UserDefaults.standard.set(timePicker.date, forKey: "timePickerValue")
    }

}

// MARK: - TableView 알림페이지 메뉴 테이블
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
            if let selectedCellIndex = UserDefaults.standard.value(forKey: "SelectedCellIndex") as? Int {
                let soundNames = Array(DataManager.notificationSoundList.keys).sorted()
                let selectedSoundName = soundNames[selectedCellIndex]
                cell.traillingLabel.text = selectedSoundName
            } else {
                cell.traillingLabel.text = ""
            }
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
                if let weatherCellStatus = weatherCellStatus {
                    cell.accessoryType = weatherCellStatus ? .checkmark : .none
                } else {
                    cell.accessoryType = .none
                }
                cell.layer.addSublayer(underline)
            } else if indexPath.row == 1 {
                cell.leadingLabel.text = "온도" // 현재 밖에 날씨는 ~~(18)도이고 체감온도는 ~~(25)입니다.
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
        
        if tableView == tableView1 {
            if notificationSwitch.isOn {
                self.navigationController?.pushViewController(SelectNotificationSoundViewController(), animated: true)
            }
        } else if tableView == tableView2 {
            if notificationSwitch.isOn {
                
                
                if let cell = tableView.cellForRow(at: indexPath) {
                    if indexPath.row == 0 {
                        // 날씨
                        cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark
                        
                        let cellStatus = cell.accessoryType == .checkmark
                        if (cellStatus == true) {
                            UserDefaults.standard.set(true, forKey: "weatherCellSelectedKey")
                        } else {
                            UserDefaults.standard.set(false, forKey: "weatherCellSelectedKey")
                        }
                        
                    } else if indexPath.row == 1 {
                       // 온도
                        cell.accessoryType = (cell.accessoryType == .checkmark) ? .none : .checkmark

                        let cellStatus = cell.accessoryType == .checkmark
                        if (cellStatus == true) {
                            UserDefaults.standard.set(true, forKey: "temperatureCellSelectedKey")
                        } else {
                            UserDefaults.standard.set(false, forKey: "temperatureCellSelectedKey")
                        }
                    }
                }
            }
        }
    }
}

