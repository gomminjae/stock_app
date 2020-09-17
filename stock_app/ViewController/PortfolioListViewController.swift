//
//  PortfolioListViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/09/01.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import RealmSwift


enum Mode {
    case view
    case select
}

class PortfolioListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var addFolderButton: UIBarButtonItem!
    @IBOutlet weak var deleteCancelButton: UIBarButtonItem!
    
    
    var folders: Results<StockList>!
    var stocks: Results<Stock>!
    var realm = RealmManager.shared.realm
    var notificationToken: NotificationToken?
    
    var viewMode: Mode = .view
    
    var selectedIndexPath: [IndexPath: Bool] = [:]
    
    

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
        vc.popupType = .folder
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @IBAction func deleteFolderTapped(_ sender: Any) {
        
        if viewMode == .select {
            print("select")
        } else { print("view")}
        viewMode = viewMode == .view ? .select : .view
        
        
    }
    
    @IBAction func deleteCancelTapped(_ sender: Any) {
        viewMode = viewMode == .select ? .view : .select
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
       
        switch viewMode {
        case .view:
            performSegue(withIdentifier: "showPortfolio", sender: folders[indexPath.item])
        case .select:
            selectedIndexPath[indexPath] = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if viewMode == .select {
            selectedIndexPath[indexPath] = false
        }
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



extension PortfolioListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return folders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return folders[row].title
    }
}




extension PortfolioListViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
