//
//  DetailViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/28.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

protocol PassStockDelegate: class {
    func sendStock(_ stock: Stock)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var stock = Stock()
    var news = [News]()
    var category: String?
    var realm = RealmManager.shared.realm
    
    var data: Results<Stock>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(stock)")
        stockNameLabel.text = stock.stockName
        categoryLabel.text = category
        
        data = realm.objects(Stock.self).filter("stockName = '\(self.stock.stockName)'")
        
        setNavigationBar()
        setupTableView()
        
        fetchNews()
        logTextView.isEditable = false
        
        logTextView.attributedText = BulletString.createBulletedList(fromStringArray: Array(stock.info), font: UIFont.systemFont(ofSize: 20))
        logTextView.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewwillappear")
        data = realm.objects(Stock.self).filter("stockName = '\(self.stock.stockName)'")
        logTextView.attributedText = BulletString.createBulletedList(fromStringArray: Array(stock.info), font: UIFont.systemFont(ofSize: 20))
        logTextView.backgroundColor = .white
    }
    
    private func setNavigationBar() {
        let bar = self.navigationController?.navigationBar
        bar?.setBackgroundImage(UIImage(), for: .default)
        bar?.shadowImage = UIImage()
        bar?.backgroundColor = .clear
    }
    
    private func setupTableView() {
        let nibName = UINib(nibName: NewsCell.reusableIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: NewsCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func fetchNews() {
        APIManager.getSearchResults(stock.stockName, display: 10) { news in
            DispatchQueue.main.async {
                self.news = news
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addInfoTapped(_ sender: Any) {
        let vc = PopUpViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.popupType = .info
        vc.stock = self.stock
        present(vc, animated: true)
    }
  
}

extension DetailViewController: UITableViewDataSource {
    
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

extension DetailViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    

}
