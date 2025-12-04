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
  
    
    
}
struct ExpenceSections :Codable
{
    let date: String
    var items : [MoneyModel]
    
}

