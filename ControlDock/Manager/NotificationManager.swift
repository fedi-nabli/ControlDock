//
//  NotificationManager.swift
//  ControlDock
//
//  Created by Fedi Nabli on 18/8/2024.
//

import Foundation

import UserNotifications

class NotificationManager {
    func sendNotification(_ title: String, subtitle: String? = nil, body: String) {
        let content: UNMutableNotificationContent = UNMutableNotificationContent()
        content.title = title
        content.body = body
        if (subtitle != nil) {
            content.subtitle = subtitle ?? ""
        }
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) {
            error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Notification added")
            }
        }
    }
}
