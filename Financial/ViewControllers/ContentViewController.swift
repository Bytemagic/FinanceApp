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
    
    
    
    @IBAction func clickClose(_ sender: UIButton)
    {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: "PresentViewed")
        dismiss(animated: true)
    }
    

    
}
