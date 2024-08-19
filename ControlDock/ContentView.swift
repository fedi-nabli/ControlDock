//
//  ContentView.swift
//  ControlDock
//
//  Created by Fedi Nabli on 17/8/2024.
//

import SwiftUI

import AppKit
import UserNotifications

struct ContentView: View {
    @State private var notificationManager: NotificationManager = NotificationManager()
    @State private var notificationDelegate: NotificationDelegate = NotificationDelegate()
    
    // Timer variables
    @State private var timerInterval: TimeInterval = 300
    @State private var lastCheckTime: Date = Date()
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    
    @State private var batteryLevel: Int = 0
    @State private var isBatteryCharging: Bool = false
    @State private var batteryStatus: BatteryIcon = .batteryFull
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: BatteryUtilities.percentageToIconName(batteryPercentage: batteryLevel, isCharging: isBatteryCharging))
                    .imageScale(.medium)
                    .foregroundStyle(.white)
                Text("Battery status:")
                Text(isBatteryCharging ? "Charging" : "On Battery")
                Text(String(batteryLevel))
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .frame(width: 300, height: 200)
        .onAppear() {
            askUserPermissions()
            updateBatteryInfo()
        }
        .onReceive(timer) {
            currentTime in
            if currentTime.timeIntervalSince(lastCheckTime) >= timerInterval {
                updateBatteryInfo()
                print(batteryLevel)
                checkBatteryFull()
                updateTimerInterval()
                lastCheckTime = currentTime
            }
        }
    }
    
    func askUserPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {
            (granted, error) in
            if (error != nil) {
                print("Something went wrong")
            } else if (granted) {
                print("Permission Granted")
                center.delegate = notificationDelegate
            } else {
                print("Permission denied")
            }
        })
    }
    
    func updateBatteryInfo() {
        let (percentage, isCharging) = BatteryUtilities.getBatteryInfo()
        self.$batteryLevel.wrappedValue = Int(percentage)
        self.isBatteryCharging = isCharging
    }
    
    func checkBatteryFull() {
        if (batteryLevel == 100 && isBatteryCharging) {
            notificationManager.sendNotification(
                "Battery Full",
                subtitle: "Your battery is fully charged",
                body: "You can unplug your device now"
            )
        }
    }
    
    func updateTimerInterval() {
        if batteryLevel >= 99 {
            timerInterval = 30 // Check every 30 seconds
        } else if batteryLevel >= 95 {
            timerInterval = 60 // Check every 60 seconds (1 min)
        } else {
            timerInterval = 300 // Check every 300 seconds (5 min)
        }
    }
}

#Preview {
    ContentView()
}
