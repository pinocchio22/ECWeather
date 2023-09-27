//
//  SearchTableViewCell.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/27.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        return collectionView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ECWeatherColor3
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerTableview()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func registerTableview() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TemperatureCollectionViewCell.self, forCellWithReuseIdentifier: "TemperatureCollectionViewCell")
    }
    
    func setLayout() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(100)
            $0.bottom.equalToSuperview()
        }
    }
    
}
extension SearchTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemperatureCollectionViewCell", for: indexPath) as? TemperatureCollectionViewCell else { return UICollectionViewCell() }
        
        cell.timeLabel.text = "12시"
        cell.temperatureLabel.text = "20c"
        
        return cell
    }
}
