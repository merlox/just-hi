//
//  MyUtilities.swift
//  MinimalisticMotivation
//
//  Created by Merunas Grincalaitis on 22/03/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import UserNotifications

class MyUtilities {
    let current = UNUserNotificationCenter.current()
    
    func askNotificationsPermission(callback: @escaping (Bool) -> Void) {
        current.requestAuthorization(options: [.alert, .sound, .badge]) { (granted: Bool, err: Error?) in
            if !granted {
                print("Notification not granted")
            } else {
                print("Notification granted")
                
                // Immediately start sending the automatic notifications every 8 hours as motivational reminders
                self.startNotifications()
            }
            callback(granted)
        }
    }
    
    func startNotifications() {
        // 2. Create a notification
       let notification = UNMutableNotificationContent()
       notification.title = "Notification title"
       notification.body = "This is my notification"
       
       // 3. Trigger the notification every 60 second:
       // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
       // Everyday at 8am:
       var date = DateComponents()
       date.hour = 8
       date.minute = 0
       let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
       
       let identifier = "UniqueNotificationMerunas"
       // You can setup multiple with different identifiers like so
       // let identifier = UUID().uuidString
       let request = UNNotificationRequest(identifier: identifier, content: notification, trigger: trigger)
       current.add(request) { (error : Error?) in
            if let theError = error {
                print("Found an error", theError)
            }
       }
    }
}
