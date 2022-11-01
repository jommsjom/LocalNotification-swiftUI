//
//  Notification.swift
//  Notification
//
//  Created by Jomms on 29/10/22.
//

import SwiftUI
import UserNotifications

final class Notification:ObservableObject{
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus:UNAuthorizationStatus?
    func reloadstatus(){
        UNUserNotificationCenter.current().getNotificationSettings{setting in
            DispatchQueue.main.async {
                self.authorizationStatus = setting.authorizationStatus
            }
            
            
        }
        
    }
    func requestauthorization(){
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.badge,.sound]) { isGranted, _ in
            DispatchQueue.main.async{
                self.authorizationStatus = isGranted ? .authorized: .denied
            }
            
            
        }
    }
    func reloadLocalNotification(){
        print("reload")
        UNUserNotificationCenter.current().getPendingNotificationRequests{ notificationss in
            DispatchQueue.main.async {
                self.notifications = notificationss
            }
        }
    }
    
    func  createlocalnotification(title: String, hour: Int, minute:Int, completion:@escaping (Error?) -> Void) {
        var datecomponent = DateComponents()
        datecomponent.hour = hour
        datecomponent.minute = minute
        datecomponent.weekday = 1
        let trigger = UNCalendarNotificationTrigger(dateMatching: datecomponent, repeats: true)
        let notificationcontent = UNMutableNotificationContent()
        notificationcontent.title = title
        notificationcontent.sound = .default
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationcontent, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler: completion)
    }
    
}
