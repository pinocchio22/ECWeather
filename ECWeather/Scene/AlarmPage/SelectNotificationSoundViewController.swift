//
//  SelectNotificationSoundViewController.swift
//  ECWeather
//
//  Created by Sanghun K. on 9/28/23.
//

import AVFoundation
import SnapKit
import UIKit

class SelectNotificationSoundViewController: BaseViewController {
    // MARK: - Properties
    
    private var audioPlayer: AVAudioPlayer?
    private var selectedCellIndex: Int?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCellIndexFromUserDefaults()
        configureUI()
    }
    
    // MARK: - Methods & Selectors

    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        
        configureNavigationBar()
        configureTableView()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        title = "알림 수신음 선택"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ECWeatherColor3 ?? .gray]
         
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .ECWeatherColor3
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadCellIndexFromUserDefaults() {
        if let selectedCellIndex = UserDefaults.standard.value(forKey: "SelectedCellIndex") as? Int {
            self.selectedCellIndex = selectedCellIndex
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NotificationSoundCell")
    }
    
    private func playNotificationSound(_ soundFileName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "caf") else {
            print("Failed to find sound file: \(soundFileName)")
            return
        }
        do {
            // 오디오 세션 초기화
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

// MARK: - TableView

extension SelectNotificationSoundViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.notificationSoundList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationSoundCell", for: indexPath)
        
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.tintColor = .ECWeatherColor3
        
        let soundNames = Array(DataManager.notificationSoundList.keys).sorted()
        if indexPath.row < soundNames.count {
            cell.textLabel?.text = soundNames[indexPath.row]
        }

        cell.accessoryType = (indexPath.row == selectedCellIndex) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedCellIndex = indexPath.row
        tableView.reloadData()
       
        let soundNames = Array(DataManager.notificationSoundList.keys).sorted()
        if soundNames.indices.contains(indexPath.row) {
            let soundName = soundNames[indexPath.row]
            print("soundName : ", soundName)
            if let fileName = DataManager.notificationSoundList[soundName] {
                print("fileName : ", fileName)
                playNotificationSound(fileName)
                
                UserDefaults.standard.setValue(selectedCellIndex, forKey: "SelectedCellIndex")
                UserDefaults.standard.setValue(fileName, forKey: "SelectedFileName")
            }
        }
    }
}
