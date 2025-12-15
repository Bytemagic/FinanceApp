//
//  UIViewController+AlertController.swift
//  Financial
//
//  Created by Mac on 04.12.2025.
//

import Foundation
import UIKit


struct AlertTextFieldModel {
    let placeholder: String
    let keyboard: UIKeyboardType
    let isSecure: Bool
}


extension UIViewController
{
    func alertPresenterAddFound(title: String,
                                message: String,
                                textFields: [AlertTextFieldModel],
                                cancelTitle: String = "Отмена",
                                okTitle: String = "OK",
                                onOK: @escaping ([String?]) -> Void)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for textField in textFields {
            alertTextField(alertController: alertController, text: textField.placeholder,keyboardType: textField.keyboard)
        }
        
        alertCancel(title: cancelTitle, alertController: alertController)
        
        alertOK(title: okTitle,alertController: alertController) { values in
            onOK(values)   // 👈 просто прокидываем наружу
        }
        present(alertController,animated: true)
    }
    
    
    
    
    func alertOK(title : String,alertController : UIAlertController, onOK: @escaping ([String]) -> Void) {
        let alertOk = UIAlertAction(title: title, style: .default) { [weak alertController] _ in
            let values = alertController?.textFields?.map { $0.text ?? "" } ?? []
            onOK(values)
        }
        alertController.addAction(alertOk)
    }
    
    
    func alertTextField(alertController : UIAlertController,text : String, keyboardType : UIKeyboardType)
    {
        alertController.addTextField
        {
            (textField) in
            
            textField.placeholder = text
            textField.keyboardType = keyboardType
            
        }
        
    }
    func alertCancel(title : String,alertController : UIAlertController)
    {
        let alertClose = UIAlertAction(title: title, style: .cancel)
        alertController.addAction(alertClose)
    }
    
    func hideKeyboardWhenTappedAround() {
          let tap = UITapGestureRecognizer(target: self,
                                           action: #selector(dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
      }

      @objc private func dismissKeyboard() {
          view.endEditing(true)
      }
   
    
    
    
    
}
