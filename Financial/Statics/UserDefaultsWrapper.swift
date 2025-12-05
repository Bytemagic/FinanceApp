//
//  UserDefaultsWrapper.swift
//  Financial
//
//  Created by Mac on 05.12.2025.
//

import Foundation

class UserDefaultsWrapper
{
    static let instance = UserDefaultsWrapper()
    
    private init() {}
    
    
    func hasValue(_ key: UserKeys) -> Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
    
    func getString(_ key: UserKeys) -> String {
        return UserDefaults.standard.string(forKey : key.rawValue) ?? ""
    }
    
    func getInt(_ key: UserKeys) -> Int {
        return UserDefaults.standard.integer(forKey :key.rawValue)
    }
    
    func getBool(_ key: UserKeys) -> Bool {
        return UserDefaults.standard.bool(forKey :key.rawValue)
    }
    
    func setValue(forKey key: UserKeys, value: Any) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    func checkKey<T>(forKey key: UserKeys, defaultValue: T) {
        if !hasValue(key) {
            setValue(forKey: key, value: defaultValue)
            
        }
    }
    
    
    
    
}

enum UserKeys : String
{
    case startMoney
    case everyDayMoney
    case piggyBank
    
}

