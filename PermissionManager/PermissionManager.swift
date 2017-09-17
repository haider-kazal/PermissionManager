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
    static let shared = PermissionManager()
    
    private init() { }
}

public extension PermissionManager {
    public func permissionStatus(for type: PermissionType) -> PermissionStatus {
        switch type {
        case .bluetooth:
            return checkPermissionState(for: BluetoothPermissionState())
        case .camera:
            return checkPermissionState(for: CameraPermissionState())
        case .contacts:
            return checkPermissionState(for: ContactPermissionState())
        case .events:
            return checkPermissionState(for: EventPermissionState())
        case .locationAlways:
            return checkPermissionState(for: LocationAlwaysState())
        case .locationWhileUsing:
            return checkPermissionState(for: LocationWhileUsingState())
        case .microphone:
            return checkPermissionState(for: MicrophonePermissionState())
        case .motion:
            return checkPermissionState(for: MotionPermissionState())
        case .notifications:
            return checkPermissionState(for: NotificationPermissionState())
        case .photos:
            return checkPermissionState(for: PhotosPermissionState())
        case .reminders:
            return checkPermissionState(for: ReminderPermissionState())
        }
    }
    
    private func checkPermissionState(for type: PermissionState) -> PermissionStatus {
        return type.status
    }
}
