//
//  AddPortfolioViewController.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/30.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import UIKit
import TextFieldEffects
import RealmSwift


class AddPortfolioViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: HoshiTextField!
    @IBOutlet weak var stockNameLabel: HoshiTextField!
    @IBOutlet weak var categoryLabel: HoshiTextField!
    @IBOutlet weak var buyLabel: HoshiTextField!
    @IBOutlet weak var sellLabel: HoshiTextField!
    @IBOutlet weak var amountLabel: HoshiTextField!
    
    let sections = ["기술","바이오", "엔터테이먼트", "금융", "운송", "원자재", "에너지", "화학"]
    
    
    var realm = RealmManager.shared.realm
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        setDatePickerView()
        setupCategoryPickerView()
        navigationController?.navigationBar.tintColor = .white
        
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
           self.view.endEditing(true)
       }

       func setDatePickerView() {
           self.dateLabel.setDatePicker(target: self, selector: #selector(tapDone))
       }
    
    func setupCategoryPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        categoryLabel.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(pickerViewAction))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(pickerViewAction))
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.categoryLabel.inputAccessoryView = toolBar
    }
    @objc func pickerViewAction() {
        self.categoryLabel.resignFirstResponder()
    }
    
    @objc func tapDone() {
        if let datePicker = self.dateLabel.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.dateLabel.text = dateformatter.string(from: datePicker.date)
        }
        self.dateLabel.resignFirstResponder()
    }
    
    @IBAction func setupButton(_ sender: Any) {
        let data = Stock()
        data.stockName = stockNameLabel.text ?? ""
        data.category = categoryLabel.text ?? ""
        data.buy = buyLabel.toInt()
        data.sell = sellLabel.toInt()
        data.amount = amountLabel.toInt()
        data.date = dateLabel.toDate()
        RealmManager.shared.creat(data)
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


extension AddPortfolioViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return Category.allCases.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return sections[row]
       }
}


//MARK: PickerView Delegate
extension AddPortfolioViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryLabel.text = sections[row]
    }
}
