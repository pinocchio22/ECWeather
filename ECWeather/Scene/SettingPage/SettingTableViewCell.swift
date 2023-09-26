//
//  SettingTableViewCell.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/26.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

    func setLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(20)
            $0.bottom.equalTo(self).offset(-20)
            $0.leading.equalTo(self).offset(10)
            $0.trailing.equalTo(self).offset(-10)
        }
    }
}
