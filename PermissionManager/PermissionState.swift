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
import EventKit
import Photos

protocol PermissionState {
    var status: PermissionStatus { get }
}

protocol PermissionRequest {
    func requestPermission()
}

final class BluetoothPermissionState: PermissionState {
    var status: PermissionStatus {
        switch CBPeripheralManager.authorizationStatus() {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

final class CameraPermissionState: PermissionState {
    var status: PermissionStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

final class ContactPermissionState: PermissionState {
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

final class EventPermissionState: PermissionState {
    var status: PermissionStatus {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

final class LocationAlwaysState: PermissionState {
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

final class LocationWhileUsingState: PermissionState {
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

final class MicrophonePermissionState: PermissionState {
    var status: PermissionStatus {
        switch AVAudioSession.sharedInstance().recordPermission() {
        case .granted:          return .authorized
        case .denied:           return .denied
        case .undetermined:     return .notDetermined
        }
    }
}

final class MotionPermissionState: PermissionState {
    var status: PermissionStatus {
        return .notDetermined
    }
}

final class NotificationPermissionState: PermissionState {
    var status: PermissionStatus {
        return .notDetermined
    }
}

final class PhotosPermissionState: PermissionState {
    var status: PermissionStatus {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}

final class ReminderPermissionState: PermissionState {
    var status: PermissionStatus {
        switch  EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .restricted
        }
    }
}
