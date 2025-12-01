//
//  ViewController.swift
//  Financial
//
//  Created by Mac on 30.11.2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var startBalanceInfoLabel: UILabel!
    
    @IBOutlet weak var currrentDayUseMoney: UILabel!
    
    @IBOutlet weak var dayRemainsLabel: UILabel!
    
    @IBOutlet weak var reactLabel: UILabel!
    
    var startMoney : Int = 1
    {
        didSet
        {
            startBalanceInfoLabel.text = "Стартовые финансы: \(startMoney)р."
            calculateDays()
            
        }
    }
    var everyDayMoney : Int = 1
    {
        didSet
        {
            currrentDayUseMoney.text = "Среднее ежедневное: \(everyDayMoney)р."
            calculateDays()
            
            
        }
    }
    
    var dayRemains : Int
    {
        return startMoney/everyDayMoney
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMoney = 1000000
        everyDayMoney = 4500
        
        
        headerLabel.textColor = .white
        dayRemainsLabel.textColor = .white
        headerLabel.text = "Мои Финансы"
        
        
        startBalanceInfoLabel.isUserInteractionEnabled = true
        
        
        currrentDayUseMoney.isUserInteractionEnabled = true
        
        
        let tapGestureStart = UITapGestureRecognizer(target: self, action: #selector(labelTappedStart))
        startBalanceInfoLabel.addGestureRecognizer(tapGestureStart)
        
        let tapGestureEvery = UITapGestureRecognizer(target: self, action: #selector(labelTappedEvery))
        currrentDayUseMoney
            .addGestureRecognizer(tapGestureEvery)
        
    }
    
    
    private func calculateDays()
    {
        let targetDate = Calendar.current.date(byAdding: .day, value: dayRemains, to: Date()) ?? Date()
        
        // 3. Форматируем конечную дату для отображения
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM" // Пример формата: 31 Декабря 2025
        dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем русский язык
        
        let formattedDate = dateFormatter.string(from: targetDate)
        dayRemainsLabel.text = "Хватит примерно на \(dayRemains) дней. До \(formattedDate)"
        
        
        if dayRemains>30
        {
            reactLabel.text = "😇"
        }
        else
        {
            reactLabel.text = "🥶"
        }
        
        
    }
    
    @objc private func labelTappedStart(_ sender : UITapGestureRecognizer)
    {
        let alertController = UIAlertController(title: "Стартовые финансы", message: "Введите доступные средства", preferredStyle: .alert)
        alertController.addTextField
        {
            (textField) in
            
            textField.placeholder = "\(self.startMoney)"
            textField.keyboardType = .numberPad
        }
        
        let alertOk = UIAlertAction(title: "OK", style: .default)
        {
            [weak alertController] _ in
            
            guard let textFields = alertController?.textFields,
                  let inputTextField = textFields.first,
                  let inputText = inputTextField.text else {
                // Обработка ошибки, если поле не найдено или пустое
                print("Ошибка: Текстовое поле не найдено или недоступно.")
                return
            }
            
            // 5. Обработка введенной строки
            
            if inputText.isEmpty {
                print("Введена пустая строка. Пожалуйста, введите текст.")
                // Можно снова показать алерт или выдать ошибку
                return
                
            }
            
            if let money = Int(inputText)
            {
                self.startMoney = money
                
            }
            
            
            
            
            
        }
        
        let alertClose = UIAlertAction(title: "Закрыть", style: .cancel)
        alertController.addAction(alertOk)
        alertController.addAction(alertClose)
        
        present(alertController,animated: true)
        
        
    }
    @objc private func labelTappedEvery(_ sender : UITapGestureRecognizer)
    {
        let alertController = UIAlertController(title: "Eжедневные средние", message: "Введите сумму средних трат", preferredStyle: .alert)
        alertController.addTextField
        {
            (textField) in
            
            textField.placeholder = "\(self.everyDayMoney)"
            textField.keyboardType = .numberPad
        }
        
        let alertOk = UIAlertAction(title: "OK", style: .default)
        {
            [weak alertController] _ in
            
            guard let textFields = alertController?.textFields,
                  let inputTextField = textFields.first,
                  let inputText = inputTextField.text else {
                // Обработка ошибки, если поле не найдено или пустое
                print("Ошибка: Текстовое поле не найдено или недоступно.")
                return
            }
            
            // 5. Обработка введенной строки
            
            if inputText.isEmpty {
                print("Введена пустая строка. Пожалуйста, введите текст.")
                // Можно снова показать алерт или выдать ошибку
                return
                
            }
            
            if let money = Int(inputText)
            {
                self.everyDayMoney = money
                
            }
            
            
            
            
            
        }
        
        let alertClose = UIAlertAction(title: "Закрыть", style: .cancel)
        alertController.addAction(alertOk)
        alertController.addAction(alertClose)
        
        present(alertController,animated: true)
        
        
    }
    
    
    
}

