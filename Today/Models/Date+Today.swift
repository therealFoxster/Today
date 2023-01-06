//
//  Date+Today.swift
//  Today
//
//  Created by Huy Bui on 2023-01-04.
//

import Foundation

extension Date {
    var dayAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormatString = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormatString, timeText)
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormatString = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateAndTimeFormatString, dateText, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today format string")
        } else {
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
