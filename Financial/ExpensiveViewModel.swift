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
  
    func addExpense(dateFound: Date,descFound: String, moneyFound: Int) {
        let newExpense = MoneyModel(dateFound: dateFound,descFound: descFound, moneyFound: moneyFound)
        expenses.append(newExpense)
     
    }

    func getExpenses() -> [MoneyModel] {
        return expenses
    }
    
    func getSectionsCount() -> Int
    {
        var listOfDatas = [String]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM" // Пример формата: 31 Декабря 2025
        dateFormatter.locale = Locale(identifier: "ru_RU") // Устанавливаем русский язык
        
     
        
        for exp in expenses
        {
            let formattedDate = dateFormatter.string(from:  exp.dateFound)
            if (!listOfDatas.contains(formattedDate)) {listOfDatas.append(formattedDate)}
        }
        
        return listOfDatas.count
        
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
