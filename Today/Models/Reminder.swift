//
//  Reminder.swift
//  Today
//
//  Created by Huy Bui on 2023-01-04.
//

import Foundation

struct Reminder: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete: Bool = false
    
    // Memberwise initializer will be created automatically.
}

//extension [Reminder] {
extension Array where Element == Reminder {
    func indexOfReminder(withId id: Reminder.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

#if DEBUG // Compiler directive that ensures code enclosed is only compiled on debug builds.
extension Reminder {
    static var sampleData = [
        Reminder(title: "Submit reimbursement report",
                 dueDate: Date().addingTimeInterval(800.0),
                 notes: "Don't forget about taxi receipts"),
        Reminder(title: "Code review",
                 dueDate: Date().addingTimeInterval(14000.0),
                 notes: "Check tech specs in shared folder",
                 isComplete: true),
        Reminder(title: "Pick up new contacts",
                 dueDate: Date().addingTimeInterval(24000.0),
                 notes: "Optometrist closes at 6:00PM"),
        Reminder(title: "Add notes to retrospective",
                 dueDate: Date().addingTimeInterval(3200.0),
                 notes: "Collaborate with project manager", isComplete: true),
        Reminder(title: "Interview new project manager candidate",
                 dueDate: Date().addingTimeInterval(60000.0),
                 notes: "Review portfolio"),
        Reminder(title: "Mock up onboarding experience",
                 dueDate: Date().addingTimeInterval(72000.0),
                 notes: "Think different"),
        Reminder(title: "Review usage analytics",
                 dueDate: Date().addingTimeInterval(83000.0),
                 notes: "Discuss trends with management"),
        Reminder(title: "Confirm group reservation",
                 dueDate: Date().addingTimeInterval(92500.0),
                 notes: "Ask about space heaters"),
        Reminder(title: "Add beta testers to TestFlight",
                 dueDate: Date().addingTimeInterval(101000.0),
                 notes: "v0.9 out on Friday")
    ]
}
#endif
