//
//  DevicesDataSource.swift
//  supported_devices_ios
//
//  Created by Smit Sonani on 24/09/21.
//

import Foundation

struct DevicesDataSource {
    private let devices = [
        "MacBook (Early 2016 or newer)",
        "MacBook Air (Early 2015 or newer)",
        "MacBook Pro (Early 2015 or newer)",
        "Mac mini (Late 2014 or newer)",
        "iMac (Late 2015 or newer)",
        "iMac Pro (2017 or newer)",
        "Mac Pro (Late 2013 or newer)"
    ]
    
    func getRandomDevice() -> String {
        return devices.randomElement()!
    }
}
