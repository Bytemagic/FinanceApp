//
//  WebRequestWrapper.swift
//  Financial
//
//  Created by Roman on 15.01.2026.
//

import Foundation
import Alamofire

private struct CBRResponse: Decodable {
    let Valute: [String: Currency]
    struct Currency: Decodable {
        let Value: Double
    }
}

class WebRequestWrapper
{
    static let instance = WebRequestWrapper()
    
    func createRequestCurrency(completion: @escaping (String?) -> Void) {
        let url = "https://www.cbr-xml-daily.ru/daily_json.js"
        AF.request(url)
            .validate()
            .responseDecodable(of: CBRResponse.self) { response in
                switch response.result {
                case .success(let cbr):
                    if let usd = cbr.Valute["USD"] {
                        let valueString = String(usd.Value)
                        print("Официальный курс USD к RUB:", valueString)
                        completion(valueString)
                    } else {
                        print("Не получилось обработать ответ: нет USD в Valute")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Нет данных: \(error.localizedDescription)")
                    completion(nil)
                }
            }
    }
    
    // Backward-compatibility wrapper for existing call sites
  
    
}
