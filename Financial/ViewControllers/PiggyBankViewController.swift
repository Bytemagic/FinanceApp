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
        
        titleLabel.isHidden = true
        segmentTargets.isHidden = true
        targetProgress.isHidden = true
        targetImage.isHidden = true
        targetSummLabel.isHidden = true
        targetNameLabel.isHidden = true
        buttonAddMoney.isHidden = true
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    func loadDataToView(index : Int)
    {
        piggy = piggyModel.getpiggyBanks()
        if piggy == nil {return}
        titleLabel.isHidden = false
        segmentTargets.isHidden = false
        targetProgress.isHidden = false
        targetImage.isHidden = false
        targetSummLabel.isHidden = false
        targetNameLabel.isHidden = false
        buttonAddMoney.isHidden = false
        targetNameLabel.text = piggy[index].targetName
        targetSummLabel.text = "Накопил \(piggy[index].targetMoney) из \((piggy[index].targetSumm))"
        targetProgress.setProgress(Float((piggy[index].targetMoney/piggy[index].targetSumm)/100), animated: true)
        
        
        
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
            loadDataToView(index: 0)
           
        }
        
        
    }
    
    
    @IBAction func addMoneyToTarget(_ sender: UIButton) {
        
    }
    

}
