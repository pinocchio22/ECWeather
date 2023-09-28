//
//  SelectNotificationSoundCell.swift
//  ECWeather
//
//  Created by Sanghun K. on 9/28/23.
//

import UIKit

class SelectNotificationSoundCell: UITableViewCell {
    
    let leadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    let traillingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    let traillingImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(leadingLabel)
        contentView.addSubview(traillingLabel)
        contentView.addSubview(traillingImage)
        
        leadingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        traillingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(traillingImage.snp.leading).offset(-10)
        }
        traillingImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
