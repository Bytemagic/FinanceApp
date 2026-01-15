//
//  PiggyBankViewController.swift
//  Financial
//
//  Created by Mac on 05.12.2025.
//

import UIKit
import PhotosUI

class PiggyBankViewController: UIViewController {
    
    var piggyModel : PiggyBankViewModel!
    
    var piggy : [PiggyBankModel]!
    
    @IBOutlet weak var addNewTargetButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
   
    @IBOutlet weak var segmentTargets: UISegmentedControl!
    
    @IBOutlet weak var targetProgress: UIProgressView!
    @IBOutlet weak var targetImage: UIImageView!
    
    @IBOutlet weak var targetSummLabel: UILabel!
    
    @IBOutlet weak var buttonAddMoney: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        piggyModel = PiggyBankViewModel()
        piggyModel.loadExpenses()
        titleLabel.textColor = .white
        targetSummLabel.textColor = .white
        viewActivator(acivated: true)
        checkButtons()
        
        WebRequestWrapper.instance.createRequestCurrency { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.titleLabel.text = result ?? String(localized: "MyPiggies")
            }
        }
        
        
       
       // titleLabel.text = String(localized: "MyPiggies")
        
        addNewTargetButton.setTitle(String(localized: "AddNewTargetButton"),for: .normal)
        
        buttonAddMoney.setTitle(String(localized: "AddMoneyInPiggy"), for: .normal)
        
        
        
        if (piggyModel.getpiggyBanksCount()>0) {
            loadDataToView(index: 0)
            targetImage.isUserInteractionEnabled = true
        }
        
        let tapGestureStart = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        targetImage.addGestureRecognizer(tapGestureStart)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
        
        
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
      
        targetSummLabel.text = String(format: String(localized: "PiggyBank"),"\(piggy[index].targetMoney)","\((piggy[index].targetSumm))")
        
        
        
        let progress = Float(piggy[index].targetMoney) / Float(piggy[index].targetSumm)
        targetImage.image = loadImageFromDocuments(name : piggy[index].targetImage)
        if targetImage.image == nil {   targetImage.image = UIImage(named: "Sample") }
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
        buttonAddMoney.isHidden = acivated
        
        
        
    }
    func saveImageToDocuments(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 0.9) else { return }
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(name)
        
        try? data.write(to: url)
    }
    
    func loadImageFromDocuments(name: String) -> UIImage? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(name)
        
        return UIImage(contentsOfFile: url.path)
    }
    
    @IBAction func clickNewTargetButton(_ sender: UIButton)
    {
        super.alertPresenterAddFound(title: "NewTarget",
                                     message: "InputData",
                                     textFields:
                                        [
                                            AlertTextFieldModel(placeholder: "Цель", keyboard: .default, isSecure: false),
                                            AlertTextFieldModel(placeholder: "", keyboard: .numberPad, isSecure: false)
                                        ]
                                     ,cancelTitle: "CloseAlert",
                                     okTitle: "OkAlert"
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
        super.alertPresenterAddFound(title: "AddMoneyAlert",
                                     message: "HowMuch",
                                     textFields:
                                        [
                                            AlertTextFieldModel(placeholder: "0", keyboard: .numberPad, isSecure: false)
                                        ]
                                     ,cancelTitle: "CloseAlert",
                                     okTitle: "OkAlert"
        )
        { [weak self] values in
            guard let self = self else { return }
            
            let money = Int(values[0] ?? "") ?? 0
            self.piggyModel.changeMoney(index: segmentTargets.selectedSegmentIndex,money : money)
            loadDataToView(index: segmentTargets.selectedSegmentIndex)
            
            
        }
    }
    
    
    
    
}
extension PiggyBankViewController: PHPickerViewControllerDelegate {
    
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        
        if results.isEmpty {
            print("Выбор изображения отменён")
            return
        }
        
        guard let provider = results.first?.itemProvider else { return }
        
        if provider.canLoadObject(ofClass: UIImage.self) {
            
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    
                    guard let selectedImage = image as? UIImage else { return }
                    self.targetImage.image = selectedImage
                    let index = self.segmentTargets.selectedSegmentIndex
                    let imageName = self.piggy[index].targetImage
                    self.saveImageToDocuments(
                        image: selectedImage,
                        name: imageName
                    )
                    
                    print("Изображение сохранено: \(imageName)")
                }
            }
        }
    }
}

