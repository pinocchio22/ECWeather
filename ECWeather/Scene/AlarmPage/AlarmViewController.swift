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
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "알람"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    private let timePicker: UIPickerView! = nil // TODO: - 시간 피커
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Methods & Selectors
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
        }
        
    }
}
