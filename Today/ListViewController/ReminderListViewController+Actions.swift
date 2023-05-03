//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Huy Bui on 2023-01-06.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
