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
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Search"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setLayout() {
        
    }
    
}
