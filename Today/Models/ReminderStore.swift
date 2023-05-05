//
//  ReminderStore.swift
//  Today
//
//  Created by Huy Bui on 2023-05-05.
//

import Foundation
import EventKit

final class ReminderStore { // "final" class can't be subclassed.
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .authorized:
            return
        case .restricted:
            throw TodayError.accessRestricted
        case .notDetermined:
            let accessGranted = try await ekStore.requestAccess(to: .reminder)
            guard accessGranted else { throw TodayError.accessDenied }
        case .denied:
            throw TodayError.accessDenied
        @unknown default: // With the @unknown keyword, the compiler will warn if the switch becomes unexhaustive in the future (if new cases are added).
            throw TodayError.unknown
        }
    }
    
    func readAll() async throws -> [Reminder] {
        guard isAvailable else { throw TodayError.accessDenied }
        
        let predicate = ekStore.predicateForReminders(in: nil) // Narrows results to reminders only.
        
        // Suspend until awaited function (reminders(matching:)) returns.
        // Results will then be assigned to ekReminders constant.
        let ekReminders = try await ekStore.reminders(matching: predicate)
        
        let reminders: [Reminder] = try ekReminders.compactMap { ekReminder in
            do {
                return try Reminder(with: ekReminder)
            } catch TodayError.reminderHasNoDueDate {
                return nil // compactMap will discard this.
            }
        }
        return reminders
    }
    
    @discardableResult // Instruct compliler to omit warnings in cases where results returned by this function are unused.
    func save(_ reminder: Reminder) throws -> Reminder.ID {
        guard isAvailable else { throw TodayError.accessDenied }
        
        let ekReminder: EKReminder
        do {
            ekReminder = try read(with: reminder.id) // Found existing reminder.
        } catch {
            ekReminder = EKReminder(eventStore: ekStore) // Create new reminder.
        }
        ekReminder.update(using: reminder, in: ekStore)
        try ekStore.save(ekReminder, commit: true)
        
        return ekReminder.calendarItemIdentifier
    }
    
    func remove(with id: Reminder.ID) throws {
        guard isAvailable else { throw TodayError.accessDenied }
        
        let ekReminder = try read(with: id)
        try ekStore.remove(ekReminder, commit: true)
    }
    
    private func read(with id: Reminder.ID) throws -> EKReminder {
        guard let ekReminder = ekStore.calendarItem(withIdentifier: id) as? EKReminder else {
            throw TodayError.failedReadingCalendarItem
        }
        return ekReminder
    }
}
