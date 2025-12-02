//
//  ContentViewController.swift
//  Financial
//
//  Created by Mac on 02.12.2025.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var presentLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var presentText = ""
    var emojiText = " "
    var currentPage = 0
    var numberOfPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentLabel.text = presentText
        emojiLabel.text = emojiText
        closeButton.isHidden = currentPage != numberOfPages-1
     
        
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
            UIColor.systemRed.cgColor,
            UIColor.systemYellow.cgColor
        ]

        // Направление: сверху вниз
        gradient.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradient.endPoint   = CGPoint(x: 0.9, y: 1.0)

        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    
    @IBAction func clickClose(_ sender: UIButton)
    {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: "PresentViewed")
        dismiss(animated: true)
    }
    

    
}
