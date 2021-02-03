//
//  Dates+ext.swift
//  GHFollowersRepetition2
//
//  Created by Jakub Gawecki on 17/12/2020.
//

import Foundation

extension Date {
    func converToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
