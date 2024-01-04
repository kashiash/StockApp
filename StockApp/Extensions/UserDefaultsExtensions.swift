//
//  UserDefaultsExtensions.swift
//  StockApp
//
//  Created by Jacek Kosinski U on 03/01/2024.
//

import Foundation


extension UserDefaults {

    var userId: UUID? {
        get {
            guard let useridAsString = string(forKey: "userId") else {
                return nil
            }
            return UUID(uuidString: useridAsString)
        }

        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
}
