//
//  HomeViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, SendCategoryDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let category = ["기술","바이오", "엔터테이먼트", "금융", "운송", "원자재", "에너지", "화학"]
    
    
    var realm = RealmManager.shared.realm
    var notificationToken: NotificationToken?
    var portfolios: Results<Stock>!
    var news = [News]()
    var setCategory: Category?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchNews()
               
        
        setNavigationBar()
        setupTableView()
        setupCollectionView()
        
        
        //load data
        portfolios = realm.objects(Stock.self)
        tableView.reloadData()
        
        //push driven
        notificationToken = realm.observe { (noti, realm) in
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? PortfolioViewController else { return }
        guard let cell = sender as? UICollectionViewCell else { return }
        let indexPath = collectionView.indexPath(for: cell)
        vc.category = .tech
    }
    
    
    
    func setupCollectionView() {
        let nibName = UINib(nibName: CategoryCell.reusableIdentifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: CategoryCell.reusableIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    
    private func setupTableView() {
        let nibName = UINib(nibName: IssueCell.reusableIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: IssueCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func setNavigationBar() {
        let bar = self.navigationController?.navigationBar
        bar?.setBackgroundImage(UIImage(), for: .default)
        bar?.shadowImage = UIImage()
        bar?.backgroundColor = .clear
    }
    
    
    func fetchNews() {
        APIManager.getSearchResults("주식") { (news) in
            DispatchQueue.main.async {
                self.news = news
                self.tableView.reloadData()
            }
        }
    }
    
    func sendCategory(category: Category) {
        setCategory = category
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reusableIdentifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        cell.categoryLabel.text = category[indexPath.item]
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPortfolio", sender: self)
    }
}



extension HomeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueCell.reusableIdentifier, for: indexPath) as? IssueCell else { return UITableViewCell() }
        cell.titleLabel.text = news[indexPath.row].title
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}

