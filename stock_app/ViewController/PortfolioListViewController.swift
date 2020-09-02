//
//  PortfolioListViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/09/01.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit

class PortfolioListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setupCollectionView()
        collectionViewLayout()

        // Do any additional setup after loading the view.
    }
    
    
    // Send data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "test" {
            guard let vc = segue.destination as? PortfolioViewController else { return }
            
            if let index = sender as? Int {
                
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
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FolderCell.reusableIdentifier, for: indexPath) as? FolderCell else { return UICollectionViewCell() }
        
//        cell.folderNameLabel.text = "Test"
//        cell.numOfItem.text = "100 items"
        
        return cell
    }
}

extension PortfolioListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "test", sender: indexPath.item)
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
