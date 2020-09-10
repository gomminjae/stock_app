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




class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var stock = Stock()
    var news = [News]()
    var category: String?
    var realm = RealmManager.shared.realm
    var stockInfo = [String]()
    
    var data: Results<Stock>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(stock)")
        stockNameLabel.text = stock.stockName
        categoryLabel.text = category
        
        data = realm.objects(Stock.self).filter("stockName = '\(self.stock.stockName)'")//.map({ $0.info })
        print(data)
        
        setNavigationBar()
        setupTableView()
        
        fetchNews()
        logTextView.isEditable = false
        
        logTextView.attributedText = BulletString.createBulletedList(fromStringArray: stockInfo, font: UIFont.systemFont(ofSize: 20))
        logTextView.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        let alert = UIAlertController(title: "Stock Info", message: "정보를 추가하세요!", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "please enter"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            let textField = alert.textFields![0]
            let saveDate = Date()
            self.stockInfo.append(textField.text!)
                do {
                    try self.realm.write {
                        self.stock.info.append(textField.text! + "   \(saveDate.toString())")
                    }
                }catch {
                    print("\(error)")
                }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
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
