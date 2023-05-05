//
//  ReminderListStyle.swift
//  Today
//
//  Created by Huy Bui on 2023-05-04.
//

import Foundation

enum ReminderListStyle: Int, CaseIterable {
    case today  // Raw value: 0.
    case future // Raw value: 1.
    case all    // Raw value: 2.
    
    var name: String {
        switch self {
        case .today:
            return NSLocalizedString("Today", comment: "Today style name")
        case .future:
            return NSLocalizedString("Future", comment: "Future style name")
        case .all:
            return NSLocalizedString("All", comment: "All style name")
        }
    }
    
    func shouldInclude(date: Date) -> Bool {
        let isInToday = Locale.current.calendar.isDateInToday(date)
        switch self {
        case .today:
            return isInToday
        case .future:
            return (date > Date.now) && !isInToday
        case .all:
            return true
        }
    }
}
