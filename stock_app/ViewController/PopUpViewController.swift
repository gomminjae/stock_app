//
//  PopUpViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/09/01.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import TextFieldEffects

class PopUpViewController: UIViewController {
    
    private var stockList: Results<StockList>!
    private var realm = RealmManager.shared.realm
    
    
    
    
    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemIndigo.cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = false
        return view
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        button.backgroundColor = .systemIndigo
        button.layer.borderWidth = 1
        return button
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
        button.backgroundColor = .systemIndigo
        button.layer.borderWidth = 1
        return button
    }()
    
    private let popupLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemIndigo
        label.text = "Add New Folder"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let categoryTextField: HoshiTextField = {
        let textField = HoshiTextField()
        textField.placeholder = "Add new folder"
        textField.placeholderColor = .black
        textField.placeholderFontScale = 1.5
        textField.borderActiveColor = .systemIndigo
        textField.borderInactiveColor = .black
        textField.borderStyle = .none
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 17)
        
        return textField
    }()
    
    @objc func completeTapped() {
        print("completed tapped")
        let newStockList = StockList()
        newStockList.title = categoryTextField.text ?? ""
        newStockList.saveDate = Date()
        RealmManager.shared.creat(newStockList)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func dismissTapped() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.addSubview(popupView)
        popupView.addSubview(dismissButton)
        popupView.addSubview(popupLabel)
        popupView.addSubview(completeButton)
        popupView.addSubview(categoryTextField)
        setupPopUpView()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func setupPopUpView() {
        popupView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view)
            $0.width.equalTo(300)
            $0.height.equalTo(200)
        }
        dismissButton.snp.makeConstraints {
            $0.bottom.equalTo(popupView)
            $0.leading.equalTo(popupView)
            $0.width.equalTo(popupView.frame.width / 2)
            $0.height.equalTo(40)
        }
        popupLabel.snp.makeConstraints {
            $0.centerX.equalTo(popupView)
            $0.top.equalTo(0)
            $0.leading.trailing.equalTo(0)
            $0.height.equalTo(40)
        }
        categoryTextField.snp.makeConstraints {
            $0.centerX.centerY.equalTo(popupView)
            $0.leading.equalTo(popupView.snp.leading).offset(30)
        }
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(dismissButton)
            $0.leading.equalTo(dismissButton.snp.trailing)
            $0.trailing.equalTo(0)
            $0.width.equalTo(dismissButton)
            $0.height.equalTo(40)
        }
    }
}

extension PopUpViewController: UITextFieldDelegate {
    
}