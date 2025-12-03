//
//  ViewController.swift
//  Financial
//
//  Created by Mac on 30.11.2025.
//

import UIKit

class MainPageViewController: UIViewController {
    
    var viewModel: ExpenseViewModel!
    
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
        return (startMoney-viewModel.getExpensesSumm())/everyDayMoney
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "startMoney") == nil
        {
            UserDefaults.standard.setValue(200000, forKey: "startMoney")
            
        }
       
        
        if  UserDefaults.standard.object(forKey: "everyDayMoney") == nil
        {
            UserDefaults.standard.setValue(4500, forKey: "everyDayMoney")
            
        }
  
       
        startMoney = UserDefaults.standard.integer(forKey:"startMoney")
            everyDayMoney = UserDefaults.standard.integer(forKey:"everyDayMoney")
       
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.calculateDays()
    }
    
  
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradientBackground(view: view)
    }
    
    
    func setGradientBackground(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemRed.cgColor
        ]

        // Направление: сверху вниз
        gradient.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradient.endPoint   = CGPoint(x: 0.8, y: 1.0)

        view.layer.insertSublayer(gradient, at: 0)
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
        
        
        if dayRemains>10
        {
            dayRemainsLabel.text = "Хватит примерно на \(dayRemains) дней. До \(formattedDate)"
            reactLabel.text = "😇"
        }
        else
        {
            dayRemainsLabel.text = "Средств почти нет"
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
    
    
    
    @IBAction func addFound(_ sender: UIButton)
    {
        var alertController = UIAlertController(title: "Расход", message: "Введите расход", preferredStyle: .alert)
        
        alertController.addTextField
        {
            (textField) in
            
            textField.placeholder = "Трата"
         
        }
        alertController.addTextField
        {
            (textField) in
            
            textField.placeholder = "0"
            textField.keyboardType = .numberPad
         
        }
        let alertOk = UIAlertAction(title: "OK", style: .default)
        {
            [weak alertController] _ in
            
            let title = alertController?.textFields?[0].text ?? ""
            let amount = Int(alertController?.textFields?[1].text ?? "") ?? 0
            self.viewModel.addExpense(descFound: title, moneyFound: amount)
            self.calculateDays()
            
            
            
        }
        
        let alertClose = UIAlertAction(title: "Закрыть", style: .cancel)
        alertController.addAction(alertOk)
        alertController.addAction(alertClose)
        
        present(alertController,animated: true)
        
        
    }
    
    
    
    
}

