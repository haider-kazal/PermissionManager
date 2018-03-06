//
//  PermissionClasses.swift
//  PermissionManager
//
//  Created by Haider Ali Kazal on 9/18/17.
//  Copyright © 2017 Haider Ali Kazal. All rights reserved.
//

import CoreLocation

final class BluetoothPermission { }

final class CameraPermission { }

final class ContactPermission { }

final class EventPermission { }

final class LocationAlwaysPermission: NSObject {
    var completion: PermissionRequestCompletion = nil
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
}

final class LocationWhileUsingPermission: NSObject {
    var completion: PermissionRequestCompletion = nil
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
}

final class MicrophonePermission { }

final class MotionPermission { }

final class NotificationPermission { }

final class PhotosPermission { }

final class ReminderPermission { }

