//
//  UIView+Gradient.swift
//  Financial
//
//  Created by Mac on 03.12.2025.
//

import UIKit

extension UIView
{
    func setGradientBackground(colors : [CGColor] = [UIColor.systemBlue.cgColor,UIColor.systemPurple.cgColor,
                                                     UIColor.systemRed.cgColor,UIColor.systemYellow.cgColor])
    {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors =  colors
        gradient.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradient.endPoint   = CGPoint(x: 0.9, y: 1.0)
        layer.insertSublayer(gradient, at: 0)
        
    }
    
    func getGradientForTable(tableView : UITableView) -> UIView
    
    {
        let gradientView = UIView(frame: tableView.bounds)
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemYellow.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradient.endPoint   = CGPoint(x: 0.9, y: 1.0)
        
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        return gradientView
        
    }
}
