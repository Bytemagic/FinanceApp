//
//  PiggyBankViewModel.swift
//  Financial
//
//  Created by Mac on 05.12.2025.
//

import Foundation

class PiggyBankViewModel
{
    var piggyBank : [PiggyBankModel] = []{
        didSet {
            saveExpenses()  // сохраняем автоматически при изменении
            
        }
    }
    
    func getpiggyBanks() -> [PiggyBankModel] {
        return piggyBank
    }
    
    func getpiggyBanksCount() -> Int {
        return piggyBank.count
    }
    
    func addPiggy(descFound: String, moneyFound: Int) {
        
        let newExpense = PiggyBankModel(targetName: descFound, targetImage: "", targetSumm: moneyFound, targetMoney: 0)
        piggyBank.append(newExpense)
        
        
        
        
        
    }
    
    func changeMoney(index : Int, money : Int)
    {
        piggyBank[index].targetMoney += money
        
        
    }
    
    func saveExpenses() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(piggyBank) {
            UserDefaultsWrapper.instance.setValue(forKey: .piggyBank, value: encoded)
        }
    }
    
    func loadExpenses() {
        guard let data = UserDefaults.standard.data(forKey: "piggyBank") else { return }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([PiggyBankModel].self, from: data) {
            piggyBank = decoded
        }
    }
    
    func removeExpense(forDelete index: IndexPath) {
      
        
    }
    
}
