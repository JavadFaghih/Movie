//
//  StringExtension.swift
//  Movie
//
//  Created by javad faghih on 9/9/22.
//

import Foundation

extension String {
    var justYear: String {
        get {
            let dateFormmater = DateFormatter()
            dateFormmater.dateFormat =  "yyyy'-'MM'-'dd"
            let date = dateFormmater.date(from: self) ?? Date()
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year], from: date)
            let year = components.year!
            
            return String(year)
        }
    }
}
