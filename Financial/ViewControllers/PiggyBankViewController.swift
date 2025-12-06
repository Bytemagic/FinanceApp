//
//  PiggyBankViewController.swift
//  Financial
//
//  Created by Mac on 05.12.2025.
//

import UIKit

class PiggyBankViewController: UIViewController {
    
    var piggyModel : PiggyBankViewModel!
    
    var piggy : [PiggyBankModel]!
    
    @IBOutlet weak var addNewTargetButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var targetNameLabel: UILabel!
    @IBOutlet weak var segmentTargets: UISegmentedControl!
    
    @IBOutlet weak var targetProgress: UIProgressView!
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var clickAddNewTargeet: UIButton!
    @IBOutlet weak var targetSummLabel: UILabel!
    
    @IBOutlet weak var buttonAddMoney: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        piggyModel = PiggyBankViewModel()
        piggyModel.loadExpenses()
        
        
        titleLabel.textColor = .white
        targetNameLabel.textColor = .white
        targetSummLabel.textColor = .white
        
        viewActivator(acivated: true)
        checkButtons()
        if (piggyModel.getpiggyBanksCount()>0) {
            loadDataToView(index: 0)
          
           
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    func createSegments()
    {
        segmentTargets.removeAllSegments()
        for seg in piggyModel.getpiggyBanks()
        {
            segmentTargets.insertSegment(withTitle: seg.targetName,at: segmentTargets.numberOfSegments, animated: true)
        
            
        }
        
      
        
        
        
        
        
        
        
    }
    
    func checkButtons()
    {
        addNewTargetButton.isHidden = piggyModel.getpiggyBanksCount() > 2
        createSegments()
    }
    
    func loadDataToView(index : Int)
    {
        piggy = piggyModel.getpiggyBanks()
        if piggy == nil {return}
        viewActivator(acivated: false)
        targetNameLabel.text = piggy[index].targetName
        targetSummLabel.text = "Накопил \(piggy[index].targetMoney) из \((piggy[index].targetSumm))"
        
        
        let progress = Float(piggy[index].targetMoney) / Float(piggy[index].targetSumm)
        targetProgress.setProgress(progress, animated: false)
       
        segmentTargets.selectedSegmentIndex = index
        
        
        
    }
    
    func viewActivator(acivated : Bool)
    {
        titleLabel.isHidden = acivated
        segmentTargets.isHidden = acivated
        targetProgress.isHidden = acivated
        targetImage.isHidden = acivated
        targetSummLabel.isHidden = acivated
        targetNameLabel.isHidden = acivated
        buttonAddMoney.isHidden = acivated
        
        
        
    }
    
    @IBAction func clickNewTargetButton(_ sender: UIButton)
    {
        super.alertPresenterAddFound(title: "Новая цель",
                                     message: "Введите данные",
                                     textFields:
                                        [
                                            AlertTextFieldModel(placeholder: "Цель", keyboard: .default, isSecure: false),
                                            AlertTextFieldModel(placeholder: "", keyboard: .numberPad, isSecure: false)
                                        ]
                                     ,cancelTitle: "Закрыть",
                                     okTitle: "OK"
        )
        { [weak self] values in
            guard let self = self else { return }
            
            let title = values[0] ?? ""
            let amount = Int(values[1] ?? "") ?? 0
            
            self.piggyModel.addPiggy(
                descFound: title,
                moneyFound: amount)
            loadDataToView(index: self.piggyModel.getpiggyBanksCount()-1)
            checkButtons()
        }
        
        
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        loadDataToView(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func addMoneyToTarget(_ sender: UIButton)
    {
        super.alertPresenterAddFound(title: "Добавить денег",
                                     message: "Сколько закинуть?",
                                     textFields:
                                        [
                                            AlertTextFieldModel(placeholder: "0", keyboard: .numberPad, isSecure: false)
                                        ]
                                     ,cancelTitle: "Закрыть",
                                     okTitle: "OK"
        )
        { [weak self] values in
            guard let self = self else { return }
            
            let money = Int(values[0] ?? "") ?? 0
            self.piggyModel.changeMoney(index: segmentTargets.selectedSegmentIndex,money : money)
            loadDataToView(index: segmentTargets.selectedSegmentIndex)
            
           
        }
    }
    
    
}
