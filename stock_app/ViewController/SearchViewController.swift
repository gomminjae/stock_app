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
        setNavigationBar()
        setupTableViewCell()
        searchBar.delegate = self
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchBar.text = ""
        news = []
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetail" {
            guard let vc = segue.destination as? NewsLinkViewController else { return }
            if let index = sender as? Int {
                vc.detailURL = news[index].link
            }
        }
    }
    private func setNavigationBar() {
        let bar = self.navigationController?.navigationBar
        bar?.setBackgroundImage(UIImage(), for: .default)
        bar?.shadowImage = UIImage()
        bar?.backgroundColor = .clear
    }
    
    
    private func setupTableViewCell() {
        let nibName = UINib(nibName: NewsCell.reusableIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: NewsCell.reusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    

}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reusableIdentifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        cell.titleLabel.text = news[indexPath.section].title.withoutHtml
        cell.dateLabel.text = news[indexPath.section].pubDate
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        performSegue(withIdentifier: "newsDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    
    private func dismissKeyBoard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyBoard()
        
        guard let searchQuery = searchBar.text, searchQuery.isEmpty == false else { return }
        
        
        //Search Networking
        APIManager.getSearchResults(searchQuery, display: 20) { (news) in
            print("--> \(news.count)")
            DispatchQueue.main.async {
                self.news = news
                self.tableView.reloadData()
            }
        }
    }
}

