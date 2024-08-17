//
//  UtilityEnums.swift
//  ControlDock
//
//  Created by Fedi Nabli on 17/8/2024.
//

import Foundation

public enum BatteryIcon : String {
    case batteryFull = "100percent"
    case batteryThreeQuarters = "75percent"
    case batteryHalf = "50percent"
    case batteryQuarter = "25percent"
    case batteryEmpty = "0percent"
    case batteryCharging = "100percent.bolt"
    
    func getIcon() -> String {
        return "battery.\(self.rawValue)"
    }
}
