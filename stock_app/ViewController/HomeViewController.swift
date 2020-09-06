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
    
    
    private var realm = RealmManager.shared.realm
    private var notificationToken: NotificationToken?
    
    //stock elements
    //private var portfolios: Results<Stock>!
    
    //stock list
    private var folders: Results<StockList>!
    
    
    private var news = [News]()
    private var setCategory: Category?
    
    private var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchNews()
               
        
        setNavigationBar()
        setupTableView()
        setupCollectionView()
        setupCollectionViewLayout()
        
        //load data
        //portfolios = realm.objects(Stock.self)
        folders = realm.objects(StockList.self).sorted(byKeyPath: "saveDate", ascending: false)
    
        
        //push driven
        notificationToken = realm.observe { (noti, realm) in            self.collectionView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPortfolio" {
            guard let vc = segue.destination as? PortfolioViewController else { return }
            if let data = sender as? StockList {
                vc.selectedFolder = data 
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
        let nibName = UINib(nibName: FolderCell.reusableIdentifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: FolderCell.reusableIdentifier)
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
        APIManager.getSearchResults("코스피", display: 10) { (news) in
            DispatchQueue.main.async {
                self.news = news
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addFolderTapped(_ sender: Any) {
        print("add Tapped")
        let vc = PopUpViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
}
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.reusableIdentifier, for: indexPath) as? FolderCell else { return UICollectionViewCell() }
        
        cell.categoryLabel.text = folders[indexPath.item].title
        cell.numOfItem.text = "\(folders[indexPath.item].stocks.count) items"
        cell.layer.cornerRadius = 35
        
        return cell
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPortfolio", sender: folders[indexPath.item])
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueCell.reusableIdentifier, for: indexPath) as? IssueCell else { return UITableViewCell() }
        cell.titleLabel.text = news[indexPath.section].title.withoutHtml
        cell.selectionStyle = .none
        //cell.backgroundColor = .red
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
        performSegue(withIdentifier: "newsDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    
    
}

