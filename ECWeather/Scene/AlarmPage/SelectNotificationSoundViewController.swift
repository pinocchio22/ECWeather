//
//  SelectNotificationSoundViewController.swift
//  ECWeather
//
//  Created by Sanghun K. on 9/28/23.
//

import UIKit

class SelectNotificationSoundViewController: UIViewController {
    
    

    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods & Selectors
    private func configureUI() {
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        
        title = "알림음 선택"
        
//        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backButtonTapped))
//        
//        let backButton = UIBarButtonItem(barButtonSystemItem: ., target: self, action: #selector(closeButtonTapped))
//        backButton.title = "알림 설정"
        
            let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .ECWeatherColor3
    
        
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NotificationSoundCell")
    }
}

extension SelectNotificationSoundViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationSoundCell", for: indexPath)
        return cell
    }
    
}
