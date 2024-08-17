//
//  ContentView.swift
//  ControlDock
//
//  Created by Fedi Nabli on 17/8/2024.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @State private var batteryLevel: Int = 0
    @State private var isBatteryCharging: Bool = false
    @State private var batteryStatus: BatteryIcon = .batteryFull
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: percentageToIconName(batteryPercentage: batteryLevel, isCharging: isBatteryCharging))
                    .imageScale(.medium)
                    .foregroundStyle(.white)
                Text("Battery status:")
                Text(isBatteryCharging ? "Charging" : "On Battery")
                Text(String(batteryLevel))
            }
        }
        .padding()
        .onAppear() {
            let (percentage, isCharging) = getBatteryInfo()
            self.$batteryLevel.wrappedValue = Int(percentage)
            self.isBatteryCharging = isCharging
        }
    }
}

#Preview {
    ContentView()
}
