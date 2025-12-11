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
            startBalanceInfoLabel.text = "Стартовые финансы: \(startMoney) ₽"
            calculateDays()
        }
    }
    var everyDayMoney : Int = 1
    {
        didSet
        {
            currrentDayUseMoney.text = "Среднее ежедневное: \(everyDayMoney) ₽"
            calculateDays()
        }
    }
    
    var dayRemains : Int
    {
        return (startMoney-viewModel.getExpensesSumm())/everyDayMoney
    }
    var moneyRemains : Int
    {
        return startMoney-viewModel.getExpensesSumm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultsWrapper.instance.checkKey(forKey: .startMoney, defaultValue: 200000)
        UserDefaultsWrapper.instance.checkKey(forKey: .everyDayMoney, defaultValue: 4500)
        
        startMoney = UserDefaultsWrapper.instance.getInt(.startMoney)
        everyDayMoney = UserDefaultsWrapper.instance.getInt(.everyDayMoney)
        
        headerLabel.textColor = .white
        dayRemainsLabel.textColor = .white
        headerLabel.text = "Мои Финансы"
        
        startBalanceInfoLabel.isUserInteractionEnabled = true
        currrentDayUseMoney.isUserInteractionEnabled = true
        
        
        let tapGestureStart = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        startBalanceInfoLabel.addGestureRecognizer(tapGestureStart)
        let tapGestureEvery = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        currrentDayUseMoney.addGestureRecognizer(tapGestureEvery)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.calculateDays()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    @objc private func labelTapped(_ sender: UITapGestureRecognizer) {
        // sender.view — это объект, на который нажали
        if let label = sender.view as? UILabel {
            
            
            if label == startBalanceInfoLabel
            {
                super.alertPresenterAddFound(title: "Стартовые финансы",
                                             message: "Введите доступные средства",
                                             textFields:
                                                [
                                                    AlertTextFieldModel(placeholder: String(self.startMoney), keyboard: .numberPad, isSecure: false),
                                                    
                                                ]
                                             ,cancelTitle: "Закрыть",
                                             okTitle: "OK"
                )
                { [weak self] values in
                    guard let self = self else { return }
                    
                    let title = values[0] ?? ""
                    if let money = Int(title)
                    {
                        self.startMoney = money
                        
                    }
                    
                }
                
            } else if label == currrentDayUseMoney
            {
                super.alertPresenterAddFound(title: "Eжедневные средние",
                                             message: "Введите сумму средних трат",
                                             textFields:
                                                [
                                                    AlertTextFieldModel(placeholder: String(self.everyDayMoney), keyboard: .numberPad, isSecure: false),
                                                    
                                                ]
                                             ,cancelTitle: "Закрыть",
                                             okTitle: "OK"
                )
                { [weak self] values in
                    guard let self = self else { return }
                    
                    let title = values[0] ?? ""
                    if let money = Int(title)
                    {
                        self.everyDayMoney = money
                        
                    }
                }
            }
        }
    }
    
    
    
    private func calculateDays()
    {
        let targetDate = Calendar.current.date(byAdding: .day, value: dayRemains, to: Date()) ?? Date()
        
        // 3. Форматируем конечную дату для отображения
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM" // Пример формата: 31 Декабря 2025
        dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем русский язык
        
        let formattedDate = dateFormatter.string(from: targetDate)
        
        
        if dayRemains>10
        {
            dayRemainsLabel.text = "Хватит примерно на \(dayRemains) дней. До \(formattedDate)"
            reactLabel.text = "На счету \(moneyRemains) ₽  😇"
        }
        else
        {
            dayRemainsLabel.text = "Средств почти нет"
            reactLabel.text = "На счету \(moneyRemains) ₽  🥶"
        }
        
        
    }
    
    @IBAction func addFound(_ sender: UIButton)
    {
        if let addExpence = storyboard?.instantiateViewController(withIdentifier: "AddPurchaseViewController") as? CreateNewExpenceViewController
        {
            addExpence.modalPresentationStyle = .fullScreen
            addExpence.viewModel = viewModel
            present(addExpence,animated: true,completion: nil)
            
        }
        
        
        
        
        
    }
    
}



