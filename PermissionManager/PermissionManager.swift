//
//  PermissionManager.swift
//  PermissionManager
//
//  Created by Haider Ali Kazal on 9/17/17.
//  Copyright © 2017 Haider Ali Kazal. All rights reserved.
//

import AddressBook
import AVFoundation
import Contacts
import CoreBluetooth
import CoreMotion
import EventKit
import Photos

// MARK: - PermissionManager singleton initialization
public class PermissionManager {
    public static let shared = PermissionManager()
    
    private init() { }
    
    public func permissionStatus(for type: PermissionType) -> PermissionStatus {
        switch type {
        case .bluetooth:
            return getStatus(from: BluetoothPermission())
        case .camera:
            return getStatus(from: CameraPermission())
        case .contacts:
            return getStatus(from: ContactPermission())
        case .events:
            return getStatus(from: EventPermission())
        case .locationAlways:
            return getStatus(from: LocationAlwaysPermission())
        case .locationWhileUsing:
            return getStatus(from: LocationWhileUsingPermission())
        case .microphone:
            return getStatus(from: MicrophonePermission())
        case .motion:
            return getStatus(from: MotionPermission())
        case .notifications:
            return getStatus(from: NotificationPermission())
        case .photos:
            return getStatus(from: PhotosPermission())
        case .reminders:
            return getStatus(from: ReminderPermission())
        }
    }
    
    @available(iOS 8.0, *)
    public func openSettings(asking permissionType: PermissionType) {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            debugPrint("🚫 \(#function) - Line \(#line): Couldn't get Bundle Identifier")
            return
        }
        guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString.appending(bundleIdentifier)) else {
            debugPrint("🚫 \(#function) - Line \(#line): Couldn't build Settings URL")
            return
        }
        
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
    
    private func getStatus(from object: PermissionState) -> PermissionStatus {
        return object.status
    }
    
    public func askUserPermission(for type: PermissionType, completion: PermissionRequestCompletion) {
        switch type {
        case .bluetooth:
            requestPermission(for: BluetoothPermission(), completion: completion)
        case .camera:
            requestPermission(for: CameraPermission(), completion: completion)
        case .contacts:
            requestPermission(for: ContactPermission(), completion: completion)
        case .events:
            requestPermission(for: EventPermission(), completion: completion)
        case .locationAlways:
            requestPermission(for: LocationAlwaysPermission(), completion: completion)
        case .locationWhileUsing:
            requestPermission(for: LocationWhileUsingPermission(), completion: completion)
        case .microphone:
            requestPermission(for: MicrophonePermission(), completion: completion)
        case .motion:
            requestPermission(for: MotionPermission(), completion: completion)
        case .notifications:
            requestPermission(for: NotificationPermission(), completion: completion)
        case .photos:
            requestPermission(for: PhotosPermission(), completion: completion)
        case .reminders:
            requestPermission(for: ReminderPermission(), completion: completion)
        }
    }
    
    private func requestPermission(for object: PermissionRequest, completion: PermissionRequestCompletion) {
        object.requestPermission(completion: completion)
    }
}
