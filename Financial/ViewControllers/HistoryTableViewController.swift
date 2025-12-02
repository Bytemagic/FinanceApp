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
        return viewModel.getExpenses().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let expence = viewModel.getExpenses()[indexPath.row]
        cell.textLabel?.text = "\(expence.descFound) = \(expence.moneyFound)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM" // Пример формата: 31 Декабря 2025
        dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем русский язык
        
        let formattedDate = dateFormatter.string(from:  Date())
        return formattedDate
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.removeExpense(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
    
    
    
}
