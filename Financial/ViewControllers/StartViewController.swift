//
//  StartViewController.swift
//  Financial
//
//  Created by Mac on 01.12.2025.
//

import UIKit

class StartViewController: UIViewController {
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewModel = ExpenseViewModel()
        viewModel.loadExpenses()
        
        let userDefault = UserDefaults.standard
        if userDefault.bool(forKey: "PresentViewed") == true
        {
            if let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
            {
                tabBarController.modalPresentationStyle = .fullScreen
                if let addVC = tabBarController.viewControllers?[0] as? MainPageViewController {
                    addVC.viewModel = viewModel
                }
                if let listVC = tabBarController.viewControllers?[1] as? HistoryTableViewController {
                    listVC.viewModel = viewModel
                }
                present(tabBarController,animated: true,completion: nil)
                
                
                
            }
            
            
            return
        }
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController
        {
            pageViewController.modalPresentationStyle = .fullScreen
            present(pageViewController,animated: true,completion: nil)
            
            
            
        }
        
    }
    
  
    
    
    
}
