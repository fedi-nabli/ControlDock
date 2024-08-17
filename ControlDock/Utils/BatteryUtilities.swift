//
//  BatteryUtilities.swift
//  ControlDock
//
//  Created by Fedi Nabli on 17/8/2024.
//

import Foundation

import IOKit.ps

func getBatteryInfo() -> (percentage: Int, isCharging: Bool) {
    var percentage: Int = 0
    var isCharging: Bool = false
    
    if let snapshot = IOPSCopyPowerSourcesInfo()?.takeRetainedValue(),
           let sources: NSArray = IOPSCopyPowerSourcesList(snapshot)?.takeRetainedValue()
    {
        for ps in sources {
            if let powerSource = IOPSGetPowerSourceDescription(snapshot, ps as CFTypeRef)?.takeUnretainedValue() as? [String: Any] {
                if let capacity = powerSource[kIOPSCurrentCapacityKey as String] as? Int,
                   let maxCapacity = powerSource[kIOPSMaxCapacityKey as String] as? Int
                {
                    percentage = Int(Double(capacity) / Double(maxCapacity) * 100)
                }
                
                if let isChargingStatus = powerSource[kIOPSIsChargingKey as String] as? Bool {
                    isCharging = isChargingStatus
                }
            }
        }
    }
    
    return (percentage, isCharging)
}

func percentageToIconName(batteryPercentage: Int, isCharging: Bool) -> String {
    var batteryIcon: BatteryIcon
    
    if (isCharging) {
        batteryIcon = BatteryIcon.batteryCharging
        return batteryIcon.getIcon()
    }
    
    switch batteryPercentage {
        case 0...24:
            batteryIcon = BatteryIcon.batteryEmpty
        case 25...49:
            batteryIcon = BatteryIcon.batteryQuarter
        case 50...74:
            batteryIcon = BatteryIcon.batteryHalf
        case 75...99:
            batteryIcon = BatteryIcon.batteryThreeQuarters
        case 100:
            batteryIcon = BatteryIcon.batteryFull
        default:
            batteryIcon = BatteryIcon.batteryEmpty
    }
    
    return batteryIcon.getIcon()
}
