//
//  SearchViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    var news = [News]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        searchBar.delegate = self
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    private func setupTableViewCell() {
        let nibName = UINib(nibName: NewsCell.reusableIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: NewsCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reusableIdentifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        cell.titleLabel.text = news[indexPath.row].title
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
}






extension SearchViewController: UISearchBarDelegate {
    
    private func dismissKeyBoard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyBoard()
        
        guard let searchQuery = searchBar.text, searchQuery.isEmpty == false else { return }
        
        
        //Search Networking
        APIManager.getSearchResults(searchQuery) { (news) in
            print("--> \(news.count)")
            DispatchQueue.main.async {
                self.news = news
                self.tableView.reloadData()
            }
        }
    }
}

