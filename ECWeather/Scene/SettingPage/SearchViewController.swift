//
//  SearchViewController.swift
//  ECWeather
//
//  Created by 김지은 on 2023/09/26.
//

import UIKit

class SearchViewController: BaseViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        registerTableview()
        setLayout()
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "도시 또는 지역 검색"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
        }
    }
    
    func registerTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.searchKeyword.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = DataManager.shared.searchKeyword[indexPath.row]
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        DataManager.shared.searchKeyword.append(text)
        if DataManager.shared.searchKeyword == [] {
            DataManager.shared.searchKeyword.remove(at: 0)
        }
        tableView.reloadData()
    }
}
