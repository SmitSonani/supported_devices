//
//  DevicesDataSource.swift
//  supported_devices_ios
//
//  Created by Smit Sonani on 24/09/21.
//

import Foundation

struct DevicesDataSource {
    private let devices = [
        "iPhone 6S",
        "iPhone 6S Plus",
        "iPhone SE (1st generation)",
        "iPhone 7",
        "iPhone 7 Plus",
        "iPhone 8",
        "iPhone 8 Plus",
        "iPhone X",
        "iPhone XS",
        "iPhone XS Max",
        "iPhone XR",
        "iPhone 11",
        "iPhone 11 Pro",
        "iPhone 11 Pro Max",
        "iPhone SE (2nd generation)",
        "iPhone 12 Mini",
        "iPhone 12",
        "iPhone 12 Pro",
        "iPhone 12 Pro Max",
        "iPhone 13 Mini",
        "iPhone 13",
        "iPhone 13 Pro",
        "iPhone 13 Pro Max"
    ]
    
    func getRandomDevice() -> String {
        return devices.randomElement()!
    }
}
