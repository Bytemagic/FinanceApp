//
//  HistoryTableViewController.swift
//  Financial
//
//  Created by Mac on 01.12.2025.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    
    var viewModel: ExpenseViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = view.getGradientForTable(tableView: tableView)
        tableView.backgroundColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let gradientLayer = tableView.backgroundView?.layer.sublayers?.first {
            gradientLayer.frame = tableView.bounds
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.getSectionsCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let expences = viewModel.getExpenses()
        
        if  expences.count > section
        {
            return expences[section].items.count
        }
        return 0
        
      
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let expence = viewModel.getExpenses()[indexPath.section]
        cell.textLabel?.text = "\(expence.items[indexPath.row].descFound) = \(expence.items[indexPath.row].moneyFound) ₽     \(expence.items[indexPath.row].expenceCategory)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let expences = viewModel.getExpenses()
        
        if  expences.count > section
        {
            return expences[section].date
        }
        return ""
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let editExpenceView = storyboard?.instantiateViewController(withIdentifier: "EditExpenceViewController") as? EditExpenceViewController
        {
            editExpenceView.modalPresentationStyle = .fullScreen
            editExpenceView.viewModel = viewModel
            editExpenceView.choosedIndex = indexPath
            present(editExpenceView,animated: true)
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            viewModel.removeExpense(forDelete: indexPath)
            tableView.reloadData()
            
        }
    }
 
}
