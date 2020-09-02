//
//  HomeViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let category = ["기술","바이오", "엔터테이먼트", "금융", "운송", "원자재", "에너지", "화학"]
    
    
    var realm = RealmManager.shared.realm
    var notificationToken: NotificationToken?
    var portfolios: Results<Stock>!
    var news = [News]()
    var setCategory: Category?
    
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchNews()
               
        
        setNavigationBar()
        setupTableView()
        setupCollectionView()
        setupCollectionViewLayout()
        
        
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
        
        if segue.identifier == "showPortfolio" {
        guard let vc = segue.destination as? PortfolioViewController else { return }
            if let index = sender as? Int {
                vc.category = Category(rawValue: category[index])
            }
        }
        
        else if segue.identifier == "newsDetail" {
            guard let vc = segue.destination as? NewsLinkViewController else { return }
            if let index = sender as? Int {
                vc.detailURL = news[index].link
            }

        }
    }
    
    private func setupCollectionView() {
        let nibName = UINib(nibName: CategoryCell.reusableIdentifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: CategoryCell.reusableIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    
    private func setupTableView() {
        let nibName = UINib(nibName: IssueCell.reusableIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: IssueCell.reusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func setNavigationBar() {
        let bar = self.navigationController?.navigationBar
        bar?.setBackgroundImage(UIImage(), for: .default)
        bar?.shadowImage = UIImage()
        bar?.backgroundColor = .clear
    }
    
    private func setupCollectionViewLayout() {
        let spacing: CGFloat = 18
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
    }
    
    
    private func fetchNews() {
        APIManager.getSearchResults("주식", display: 10) { (news) in
            //비동기
            DispatchQueue.main.async {
                self.news = news
                self.tableView.reloadData()
            }
        }
    }
    
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reusableIdentifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        cell.categoryLabel.text = category[indexPath.item]
        cell.itemsLabel.text = "\(portfolios.filter { $0.category == self.category[indexPath.item]}.count)"
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPortfolio", sender: indexPath.item)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 16
        let totalSpacing = (2 * spacing) + (3 * spacing)
        let cellSize = (Int((collectionView.bounds.width)) - totalSpacing ) / 2
        
        return CGSize(width: cellSize, height: cellSize)
    }

}



extension HomeViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueCell.reusableIdentifier, for: indexPath) as? IssueCell else { return UITableViewCell() }
        cell.titleLabel.text = news[indexPath.row].title.withoutHtml
        cell.selectionStyle = .none
        cell.backgroundColor = .red
        //cell.descriptionLabel.text = news[indexPath.row].content
        //cell.animate()
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-->\(news[indexPath.row].title.withoutHtml)")
        selectedIndex = indexPath
        tableView.reloadRows(at: [selectedIndex], with: .none)
        //performSegue(withIdentifier: "newsDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedIndex == indexPath { return 150 }
        
        return 50
    }
    
    
    
}

