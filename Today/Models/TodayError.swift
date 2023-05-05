//
//  TodayError.swift
//  Today
//
//  Created by Huy Bui on 2023-05-05.
//

import Foundation

enum TodayError: LocalizedError {
    case accessDenied
    case accessRestricted
    case failedReadingReminders
    case reminderHasNoDueDate
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return NSLocalizedString("The app doesn't have permisison to read reminders.", comment: "Access denied error description")
        case .accessRestricted:
            return NSLocalizedString("This device doesn't allow access to reminders.", comment: "Access restricted error description")
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders.", comment: "Failed reading reminders error description")
        case .reminderHasNoDueDate:
            return NSLocalizedString("A reminder has no due date.", comment: "Reminder has no due date error description")
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "Unknown error description")
        }
    }
}
