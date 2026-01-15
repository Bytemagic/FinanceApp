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
    @IBOutlet weak var startBalanceInfoLabel: TouchableLabel!
    @IBOutlet weak var currrentDayUseMoney: TouchableLabel!
    @IBOutlet weak var dayRemainsLabel: UILabel!
    @IBOutlet weak var reactLabel: UILabel!
    
    @IBOutlet weak var addExpenceButton: UIButton!
    
    var startMoney : Int = 1
    {
        didSet
        {
            startBalanceInfoLabel.setText(text: String(format: String(localized: "StartFin"),"\(startMoney)"))
            
           
            
            calculateDays()
        }
    }
    var everyDayMoney : Int = 1
    {
        didSet
        {
            
            currrentDayUseMoney.setText(text:String(format: String(localized: "EveryDayMiddle"),"\(everyDayMoney)"))
            
            
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
        
        addExpenceButton.setTitle(String(localized: "AddExpenceButton"), for: .normal)
        headerLabel.text = String(localized: "MyFinanceLabel")
        
        startBalanceInfoLabel.isUserInteractionEnabled = true
        currrentDayUseMoney.isUserInteractionEnabled = true
        
        startBalanceInfoLabel.onTap = { [weak self] in
            
            self?.clickStartMoney()
            
            
        }
        
        currrentDayUseMoney.onTap = { [weak self] in
            
            self?.clickEveryDayMoney()
            
            
        }
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.calculateDays()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    func clickStartMoney()
    {
        alertPresenterAddFound(title: "StartFinAlert",
                               message: "InputStartMoneyAlert",
                               textFields:
                                [
                                    AlertTextFieldModel(placeholder: String(startMoney), keyboard: .numberPad, isSecure: false),
                                    
                                ]
                               ,cancelTitle: "CloseAlert",
                               okTitle: "OkAlert"
        )
        { [weak self] values in
            guard let self = self else { return }
            
            let title = values[0] ?? ""
            if let money = Int(title)
            {
                self.startMoney = money
                
            }
            
        }
        
        
    }
    
    func clickEveryDayMoney()
    {
        super.alertPresenterAddFound(title: "EveryDayAlert",
                                     message: "InputEveryDayAlert",
                                     textFields:
                                        [
                                            AlertTextFieldModel(placeholder: String(self.everyDayMoney), keyboard: .numberPad, isSecure: false),
                                            
                                        ]
                                     ,cancelTitle: "CloseAlert",
                                     okTitle: "OkAlert"
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
    
  
    
    
    
    private func calculateDays()
    {
        let targetDate = Calendar.current.date(byAdding: .day, value: dayRemains, to: Date()) ?? Date()
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let formattedDate = dateFormatter.string(from: targetDate)
        
        
        if dayRemains>10
        {
            dayRemainsLabel.text = String(format: String(localized:"MoneyDayRemains"), "\(dayRemains)","\(formattedDate)")
            reactLabel.text = String(format: String(localized :"MoneyOnDeposit"), "\(moneyRemains)")
            
        }
        else
        {
            dayRemainsLabel.text = String(localized: "NoMoney")
            reactLabel.text = String(format: "MoneyOnDepositBad", "\(moneyRemains)")
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



