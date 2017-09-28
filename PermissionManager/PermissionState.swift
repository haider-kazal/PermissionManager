//
//  PermissionState.swift
//  PermissionManager
//
//  Created by Haider Ali Kazal on 9/17/17.
//  Copyright © 2017 Haider Ali Kazal. All rights reserved.
//

import AddressBook
import AVFoundation
import Contacts
import CoreBluetooth
import CoreLocation
import CoreMotion
import EventKit
import Photos
import UserNotifications

protocol PermissionState {
    var status: PermissionStatus { get }
}

extension BluetoothPermission: PermissionState {
    var status: PermissionStatus {
        switch CBPeripheralManager.authorizationStatus() {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

extension CameraPermission: PermissionState {
    var status: PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

extension ContactPermission: PermissionState {
    var status: PermissionStatus {
        if #available(iOS 9.0, *) {
            switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized:       return .authorized
            case .denied:           return .denied
            case .notDetermined:    return .notDetermined
            case .restricted:       return .restricted
            }
        } else {
            switch ABAddressBookGetAuthorizationStatus()  {
            case .authorized:       return .authorized
            case .denied:           return .denied
            case .notDetermined:    return .notDetermined
            case .restricted:       return .restricted
            }
        }
    }
}

extension EventPermission: PermissionState {
    var status: PermissionStatus {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

extension LocationAlwaysPermission: PermissionState {
    var status: PermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else { return .restricted }
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:     return .authorized
        case .authorizedWhenInUse,
             .denied:               return .denied
        case .notDetermined:        return .notDetermined
        case .restricted:           return .restricted
        }
    }
}

extension LocationWhileUsingPermission: PermissionState {
    var status: PermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else { return .restricted }
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways,
             .authorizedWhenInUse:  return .authorized
        case .denied:               return .denied
        case .notDetermined:        return .notDetermined
        case .restricted:           return .restricted
        }
    }
}

extension MicrophonePermission: PermissionState {
    var status: PermissionStatus {
        switch AVAudioSession.sharedInstance().recordPermission() {
        case .granted:          return .authorized
        case .denied:           return .denied
        case .undetermined:     return .notDetermined
        }
    }
}

extension MotionPermission: PermissionState {
    var status: PermissionStatus {
//        let motionManager = CMMotionActivityManager()
//        let rightNow = Date()
//        motionManager.queryActivityStarting(from: rightNow, to: rightNow, to: .main) { (activities, error) in
//            guard error == nil else {
//                return
//            }
//
//            motionManager.stopActivityUpdates()
//        }
        return .notDetermined
    }
}

extension NotificationPermission: PermissionState {
    var status: PermissionStatus {
        if #available(iOS 8.0, *) {
            guard UIApplication.shared.isRegisteredForRemoteNotifications == true else {
                return .denied
            }
            return .authorized
        } else {
            let types = UIApplication.shared.enabledRemoteNotificationTypes()
            if types == UIRemoteNotificationType.alert {
                return .authorized
            } else {
                return .denied
            }
        }
    }
}

extension PhotosPermission: PermissionState {
    var status: PermissionStatus {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

extension ReminderPermission: PermissionState {
    var status: PermissionStatus {
        switch  EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}
