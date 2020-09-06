//
//  DetailNewsViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/09/02.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stockName: String = "네이버"
    var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchNews(stockName)

        
    }
    
    private func fetchNews(_ name: String) {
        
        APIManager.getSearchResults(name, display: 10) { news in
            DispatchQueue.main.async {
                print("load success")
                self.news = news
            }
        }
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: IssueCell.reusableIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: IssueCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    
    
}


extension DetailNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueCell.reusableIdentifier, for: indexPath) as? IssueCell else { return UITableViewCell() }
        
        let data = news[indexPath.row]
        
        cell.titleLabel.text = data.title
        
        return cell
    }
}

extension DetailNewsViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
}
