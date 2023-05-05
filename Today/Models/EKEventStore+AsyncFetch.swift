//
//  EKEventStore+AsyncFetch.swift
//  Today
//
//  Created by Huy Bui on 2023-05-05.
//

import Foundation
import EventKit

// EKEventStore objects can access user's calendar events & reminders.
extension EKEventStore {
    func reminders(matching predicate: NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) { reminders in
                if let reminders { // Shorted syntax for "if let reminders = reminders".
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: TodayError.failedReadingReminders)
                }
            }
        }
    }
}
