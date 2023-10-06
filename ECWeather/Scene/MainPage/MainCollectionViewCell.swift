//
//  MainCollectionViewCell.swift
//  ECWeather
//
//  Created by t2023-m0064 on 2023/10/06.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
        
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return imageView
    }()
        
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0, green: 0.0, blue: 0.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 10)
        label.textAlignment = .left
        return label
    }()
        
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0, green: 0.0, blue: 0.0, alpha: 1.0)
        label.font = UIFont(name: "Helvetica-Bold", size: 10)
        label.textAlignment = .left
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
        
    private func setupUI() {
        verticalStackView.addArrangedSubview(topLabel)
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(bottomLabel)
            
        contentView.addSubview(verticalStackView)
    
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        topLabel.textAlignment = .center
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        bottomLabel.textAlignment = .center
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
