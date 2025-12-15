//
//  ExpensiveViewModel.swift
//  Financial
//
//  Created by Mac on 01.12.2025.
//

import Foundation

class ExpenseViewModel {
    
    private var expenses: [ExpenceSections] = [] {
        didSet {
            saveExpenses()
            
        }
    }
    
    func addExpence(model : MoneyModel)
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let formattedDate = dateFormatter.string(from:  Date())
        
        if let index = expenses.firstIndex(where: {$0.date == formattedDate})
        {
            expenses[index].items.insert(model, at: 0)
            
        }
        else
        {
            let expence = ExpenceSections(date: formattedDate, items: [model])
            expenses.insert(expence, at: 0)
        }
        
    }
    
    func editExpense(forEdit : IndexPath,money: MoneyModel)
    {
        expenses[forEdit.section].items.remove(at: forEdit.row)
        expenses[forEdit.section].items.insert(money, at: forEdit.row)
        saveExpenses()
        
    }
    
    func getExpenses() -> [ExpenceSections] {
        return expenses
    }
    
    func getSectionsCount() -> Int
    {
        return expenses.count
        
    }
    
    func getExpensesSumm() -> Int {
        
        var summ = 0
        for exp in expenses
        {
            for ex in exp.items
            {
                summ+=ex.moneyFound
                
            }
            
        }
        
        return summ
    }
    
    func saveExpenses() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(expenses) {
            UserDefaultsWrapper.instance.setValue(forKey: UserKeys.expences, value: encoded)
        }
    }
    
    func loadExpenses() {
        
        guard let data = UserDefaultsWrapper.instance.getData(UserKeys.expences)  else { return }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([ExpenceSections].self, from: data) {
            expenses = decoded
        }
    }
    
    func removeExpense(forDelete index: IndexPath) {
        expenses[index.section].items.remove(at: index.row)
        
    }
}
