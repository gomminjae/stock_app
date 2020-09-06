//
//  PortfolioListViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/09/01.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import RealmSwift

class PortfolioListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var folders: Results<StockList>!
    var stocks: Results<Stock>!
    var realm = RealmManager.shared.realm
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupCollectionView()
        collectionViewLayout()
        
        folders = realm.objects(StockList.self)
        
        //stocks = realm.objects(Stock.self)

        // Do any additional setup after loading the view.
        
        notificationToken = realm.observe { noti, realm in
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
    // Send data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPortfolio" {
            guard let vc = segue.destination as? PortfolioViewController else { return }
            if let data = sender as? StockList {
                vc.selectedFolder = data
            }
        }
    }
    
    private func setNavigationBar() {
        let bar = self.navigationController?.navigationBar
        bar?.setBackgroundImage(UIImage(), for: .default)
        bar?.shadowImage = UIImage()
        bar?.backgroundColor = .clear
    }
    
    private func setupCollectionView() {
        let nibName = UINib(nibName: FolderCell.reusableIdentifier, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: FolderCell.reusableIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func collectionViewLayout() {
        let spacing: CGFloat = 16.0
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
    }
    
    
    
    @IBAction func addFolderTapped(_ sender: Any) {
        print("add Tapped")
        let vc = PopUpViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}

extension PortfolioListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.reusableIdentifier, for: indexPath) as? FolderCell else { return UICollectionViewCell() }
        
        cell.categoryLabel.text = folders[indexPath.item].title
        cell.numOfItem.text = "\(folders[indexPath.item].stocks.count)"
        cell.layer.cornerRadius = 30
        
        return cell
    }
}

extension PortfolioListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPortfolio", sender: folders[indexPath.item])
    }
}

extension PortfolioListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItem = 2
        let spacing = 16
        
        let totalSpacing = (2 * 16) + ((numberOfItem - 1) * spacing)
        let cellSize = (Int((collectionView.bounds.width)) - totalSpacing) / numberOfItem
        return CGSize(width: cellSize, height: cellSize)
    }
}
