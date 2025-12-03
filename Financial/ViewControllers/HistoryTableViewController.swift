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
        
        let headerLabel = UILabel()
        headerLabel.text = "Мои Траты"
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerLabel.textColor = .white
        headerLabel.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)
        
        tableView.tableHeaderView = headerLabel
        
        
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
             tableView.backgroundView = gradientView

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
        var alertController = UIAlertController(title: "Расход", message: "Введите расход", preferredStyle: .alert)
        
        alertController.addTextField
        {
            (textField) in
            textField.placeholder = expence.items[indexPath.row].descFound
         
        }
        alertController.addTextField
        {
            (textField) in
            textField.placeholder = " \(expence.items[indexPath.row].moneyFound)"
            textField.keyboardType = .numberPad
         
        }
        let alertOk = UIAlertAction(title: "OK", style: .default)
        {
            [weak alertController] _ in
            
            var title = alertController?.textFields?[0].text ?? expence.items[indexPath.row].descFound
            if title.count == 0 { title = expence.items[indexPath.row].descFound }
         
            let amount = Int(alertController?.textFields?[1].text ?? "") ?? expence.items[indexPath.row].moneyFound
           
            let moneyExpence = MoneyModel(descFound: title, moneyFound: amount)
            self.viewModel.editExpense(forEdit : indexPath,money: moneyExpence)
            tableView.reloadData()
        }
        
        let alertClose = UIAlertAction(title: "Закрыть", style: .cancel)
        alertController.addAction(alertOk)
        alertController.addAction(alertClose)
        
        present(alertController,animated: true)
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            viewModel.removeExpense(forDelete: indexPath)
            tableView.reloadData()
            
        }
    }
    
    
    
    
}
