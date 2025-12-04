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
        return viewModel.getExpenses()[section].items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let expence = viewModel.getExpenses()[indexPath.section]
        cell.textLabel?.text = "\(expence.items[indexPath.row].descFound) = \(expence.items[indexPath.row].moneyFound)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return viewModel.getExpenses()[section].date
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let expence = viewModel.getExpenses()[indexPath.section]
        
        super.alertPresenterAddFound(title: "Расход", message: "Введите расход", textFields:
                                        [
                                            AlertTextFieldModel(placeholder: expence.items[indexPath.row].descFound, keyboard: .default, isSecure: false),
                                            AlertTextFieldModel(placeholder: String(expence.items[indexPath.row].moneyFound), keyboard: .numberPad, isSecure: false)
                                        ])
        {
            [weak self] values in
            guard let self = self else { return }
            var title = values[0] ?? expence.items[indexPath.row].descFound
            if title.count == 0 { title = expence.items[indexPath.row].descFound }
            let amount = Int(values[1] ?? "") ?? expence.items[indexPath.row].moneyFound
            let moneyExpence = MoneyModel(descFound: title, moneyFound: amount)
            self.viewModel.editExpense(forEdit : indexPath,money: moneyExpence)
            tableView.reloadData()
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
