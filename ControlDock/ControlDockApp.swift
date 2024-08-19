//
//  ControlDockApp.swift
//  ControlDock
//
//  Created by Fedi Nabli on 17/8/2024.
//

import SwiftUI

@main
struct ControlDockApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
        /* WindowGroup {
            ContentView()
        } */
    }
}
