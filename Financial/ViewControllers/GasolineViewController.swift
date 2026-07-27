//
//  GasolineViewController.swift
//  Financial
//
//  Created by Roman on 27.07.2026.
//

import UIKit

class GasolineViewController: UIViewController {

    @IBOutlet weak var GasCount: UITextField!
    
    @IBOutlet weak var KMCount: UITextField!
    
    @IBOutlet weak var Price: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientBackground()
    }
    
    
    @IBAction func CalculateGas(_ sender: Any)
    {
        let gas = Double(GasCount.text!)!
        let km = Double(KMCount.text!)!
        let price = Double(Price.text!)!
        
        let result = km / gas * price
        
        
       print(result)
        
        
        
    }
    

    
}
