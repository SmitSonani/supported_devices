package com.example.supported_devices_android

class DevicesDataSource {
    val devices = arrayOf<String>(
        "Google Pixel 5",
        "SAMSUNG GALAXY Z FOLD 3",
        "MI 11 ULTRA",
        "SAMSUNG GALAXY S20 FE 5G",
        "ONEPLUS 9 PRO",
        "OPPO RENO 6 PRO",
        "SAMSUNG GALAXY S21 ULTRA",
        "ASUS ROG PHONE 5",
        "VIVO X60 PRO"
    )

    fun getRandomDevice(): String {
        return devices.random()
    }
}