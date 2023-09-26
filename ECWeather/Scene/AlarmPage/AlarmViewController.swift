//
//  AlarmViewController.swift
//  ECWeather
//
//  Created by t2023-m0056 on 2023/09/25.
//

import SnapKit
import UIKit

class AlarmViewController: UIViewController {
    
    // MARK: - Properties
    private let weekdays:[String] = ["일","월","화","수","목","금","토",]
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "알람"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let timePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .time
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "en_US")
        pickerView.tintColor = UIColor(red: 0.02, green: 0.23, blue: 0.31, alpha: 1.00) // TODO: - tintColor 안먹음..
        pickerView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.3)
        return pickerView
    }()

    private let weekdaysBtnStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Methods & Selectors
    private func configureUI() {
        view.backgroundColor = .white
        
        makeWeekdaysBtnStack()
        view.addSubview(titleLabel)
        view.addSubview(timePicker)
        view.addSubview(weekdaysBtnStack)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
        }
        
        timePicker.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-100)
        }
        
        weekdaysBtnStack.snp.makeConstraints {
            $0.top.equalTo(timePicker.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    private func makeWeekdaysBtnStack() {
        for day in weekdays {
            let button = UIButton(type: .custom)
            button.setTitle(day, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.textAlignment = .center
            button.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
            button.addTarget(self, action: #selector(weekdaysButtonTapped), for: .touchUpInside)
            
            button.bounds = CGRect(x: 0, y: 0, width: 25, height: 50) // TODO: - 원형 만들기
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            
            weekdaysBtnStack.addArrangedSubview(button)
        }
    }

    @objc private func weekdaysButtonTapped(sender: UIButton) {
        if sender.backgroundColor == UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0) {
            sender.backgroundColor = UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 0.3)
            // TODO: - 요일 눌렀을때 이벤트 처리
        } else {
            sender.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
        }
    }
}
