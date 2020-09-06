//
//  PortfolioViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import RealmSwift

class PortfolioViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //passed data
    var selectedFolder = StockList()
    
    
    var portfolios: Results<Stock>!
    var realm = RealmManager.shared.realm
    var notificationToken: NotificationToken?
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        setNavigationBar()
        setupTableView()
        
        portfolios = selectedFolder.stocks.sorted(byKeyPath: "saveDate", ascending: false)
        
        tableView.reloadData()
        
        notificationToken = realm.observe { (noti, realm) in
            self.tableView.reloadData()
        }
        
        categoryLabel.text = selectedFolder.title
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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStock" {
            guard let vc = segue.destination as? DetailViewController else { return }
            if let data = sender as? Stock {
                vc.stock = data
                vc.category = selectedFolder.title
            }
        }
    }

}


extension PortfolioViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return portfolios.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.reusableIdentifier, for: indexPath) as? StockCell else { return UITableViewCell() }
        let data = portfolios[indexPath.section]
        
        cell.titleLabel.text = data.stockName
        cell.dateLabel.text = data.saveDate.toString()

        return cell
    }
}


extension PortfolioViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "showStock", sender: portfolios[indexPath.section])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            RealmManager.shared.delete(portfolios[indexPath.section])
        }
    }
    

    
}
