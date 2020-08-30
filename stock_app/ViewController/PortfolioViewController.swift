//
//  PortfolioViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import RealmSwift


protocol SendCategoryDelegate: class {
    func sendCategory(category: Category)
}



class PortfolioViewController: UIViewController {
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: Category?
    var detailStock: Stock?
    var portfolios: Results<Stock>!
    var realm = RealmManager.shared.realm
    var notificationToken: NotificationToken?
    
    weak var delegate: SendCategoryDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        setNavigationBar()
        setupTableView()
        
        portfolios = realm.objects(Stock.self)
        
        tableView.reloadData()
        
        notificationToken = realm.observe { (noti, realm) in
            self.tableView.reloadData()
        }
        
        
        categoryLabel.text = category?.rawValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setNavigationBar() {
        let bar = self.navigationController?.navigationBar
        bar?.setBackgroundImage(UIImage(), for: .default)
        bar?.shadowImage = UIImage()
        bar?.backgroundColor = .clear
    }
    
    private func setupTableView() {
        let nibName = UINib(nibName: StockCell.reusableIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: StockCell.reusableIdentifier)
    }
    
    func SendStockData(data: Stock) {
        
        detailStock = data
    }
    
    
    
    
    
}


extension PortfolioViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        portfolios.filter { $0.setCategory == self.category }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.reusableIdentifier, for: indexPath) as? StockCell else { return UITableViewCell() }
        if portfolios.count == 0 {
            tableView.setEmptyView(title: "No data", message: "Please add ", image: .checkmark)
            return cell
        }else {
        
        let data = portfolios.filter { $0.setCategory == self.category }[indexPath.row]
        
        cell.titleLabel.text = data.stockName
        
        return cell
        }
    }
}


extension PortfolioViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailStock = portfolios[indexPath.row]
        
    }
    
    
}
