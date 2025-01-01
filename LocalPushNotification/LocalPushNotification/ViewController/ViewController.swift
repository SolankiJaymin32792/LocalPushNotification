//
//  ViewController.swift
//  PushNotification
//
//  Created by Jaymin on 31/12/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    //MARK: - Iboutlet
    
    //MARK: - Local variable
    
    //MARK: -  view life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermission()
    }
    
    //MARK: - checkForPermissionFor Notification
    func checkForPermission(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus{
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
                
            }
        }
    }
    
    //MARK: - dispatchNotificationForNotification
    func dispatchNotification(){
        let identifier = "my-mornig-notification"
        let title = "Time to work out!"
        let body = "Don't be a lazy little but!"
        let hour  = 18
        let minute = 13
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calender = Calendar.current
        var dateComponents = DateComponents(calendar: calender, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
        
    }
    
}


