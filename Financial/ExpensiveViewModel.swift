//
//  ExpensiveViewModel.swift
//  Financial
//
//  Created by Mac on 01.12.2025.
//

import Foundation

class ExpenseViewModel {

    private var expenses: [MoneyModel] = [] {
        didSet {
            saveExpenses()  // сохраняем автоматически при изменении
          
        }
    }

    // Замыкание для оповещения view об обновлении
  
    func addExpense(descFound: String, moneyFound: Int) {
        let newExpense = MoneyModel(descFound: descFound, moneyFound: moneyFound)
        expenses.append(newExpense)
     
    }

    func getExpenses() -> [MoneyModel] {
        return expenses
    }
    
    func getExpensesSumm() -> Int {
        
        var summ = 0
        for exp in expenses
        {
            summ+=exp.moneyFound
        }
        
        return summ
    }
    
     
    private let key = "expenses"
    
    func saveExpenses() {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(expenses) {
               UserDefaults.standard.set(encoded, forKey: key)
           }
       }

       func loadExpenses() {
           guard let data = UserDefaults.standard.data(forKey: key) else { return }
           let decoder = JSONDecoder()
           if let decoded = try? decoder.decode([MoneyModel].self, from: data) {
               expenses = decoded
           }
       }
    func removeExpense(at index: Int) {
        expenses.remove(at: index)
       
    }
}
