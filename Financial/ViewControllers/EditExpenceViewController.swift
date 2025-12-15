//
//  CreateNewExpenceViewController.swift
//  Financial
//
//  Created by Mac on 08.12.2025.
//

import UIKit

class EditExpenceViewController: UIViewController {
    
    var viewModel: ExpenseViewModel!
    
    @IBOutlet weak var buyTitle: UILabel!
    @IBOutlet weak var summTitle: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var expenceNameInputField: UITextField!
    
    @IBOutlet weak var summOfExpenceInputField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var choosedIndex = IndexPath()
    var selectedCategory :Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        buyTitle.text = String(localized: "WhatBuyLabel")
        summTitle.text = String(localized: "SummLabel")
        
        saveButton.setTitle(String(localized: "saveButton"), for: .normal)
        closeButton.setTitle(String(localized: "closeButton"), for: .normal)
        
        hideKeyboardWhenTappedAround()
 
        let expence = viewModel.getExpenses()
        
        if expence.count>choosedIndex.section
        {
            expenceNameInputField.text = expence[choosedIndex.section].items[choosedIndex.row].descFound
            summOfExpenceInputField.text = "\(expence[choosedIndex.section].items[choosedIndex.row].moneyFound)"
            let enumIndex = ExpenceType.allCases.firstIndex(of: expence[choosedIndex.section].items[choosedIndex.row].expenceCategory)
            pickerView.selectRow(enumIndex!, inComponent: 0, animated: true)
        }
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    
    
    @IBAction func closeButtonClick(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    
    @IBAction func clickSave(_ sender: UIButton) {
        
        let title = expenceNameInputField.text ?? ""
        let amount = Int(summOfExpenceInputField.text ?? "") ?? 0
        if title.isEmpty && amount == 0 {return}
        
        let moneyExpence = MoneyModel(descFound: title, moneyFound: amount, expenceCategory : ExpenceType.allCases[selectedCategory])
        viewModel.editExpense(forEdit : choosedIndex,money: moneyExpence)
      
        dismiss(animated: true)
    }
    
}

extension EditExpenceViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ExpenceType.allCases.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(ExpenceType.allCases[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = row
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
   
    
    
    
}

