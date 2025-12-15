//
//  MoneyModel.swift
//  Financial
//
//  Created by Mac on 01.12.2025.
//

import Foundation
import UIKit

struct MoneyModel : Codable
{
    let descFound : String
    let moneyFound : Int
    let expenceCategory : ExpenceType
    
}
struct ExpenceSections :Codable
{
    let date: String
    var items : [MoneyModel]
    
}

enum ExpenceType : Codable,CaseIterable
{
    case Food
    case Drink
    case It
    case Car
    case Health
    
}

