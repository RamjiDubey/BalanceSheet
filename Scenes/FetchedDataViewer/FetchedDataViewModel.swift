//
//  FetchedDataViewModel.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Foundation
import UserNotifications

final class FetchedDataViewModel: ObservableObject {
    @Published var data: [DummyDataResponse]
    
    init(data: [DummyDataResponse]) {
        self.data = data
    }
    
    func deleteAction(_ data: DummyDataResponse) {
        self.data.removeAll(where: {
            $0.id == data.id
        })
        sendLocalNotification(title: "Item Deleted", body: "\(data.name) has been removed.")
    }
    
    func sendLocalNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .defaultRingtone

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to add notification: \(error.localizedDescription)")
            }
        }
    }
    
    func updateAction() {}
}
