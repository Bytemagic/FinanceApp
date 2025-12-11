//
//  CreateNewExpenceViewController.swift
//  Financial
//
//  Created by Mac on 08.12.2025.
//

import UIKit

class CreateNewExpenceViewController: UIViewController {
    
    var viewModel: ExpenseViewModel!
    
    @IBOutlet weak var expenceNameInputField: UITextField!
    
    @IBOutlet weak var summOfExpenceInputField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var selectedCategory :Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        hideKeyboardWhenTappedAround()
        
       
        
        
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
        viewModel.addExpense(descFound: title, moneyFound: amount,category : ExpenceType.allCases[selectedCategory])
        dismiss(animated: true)
    }
}

extension CreateNewExpenceViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
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
    
    
    
    
    
    
    
}
