//
//  PermissionType.swift
//  PermissionManager
//
//  Created by Haider Ali Kazal on 9/17/17.
//  Copyright © 2017 Haider Ali Kazal. All rights reserved.
//

public enum PermissionType: CustomStringConvertible {
    case bluetooth
    case camera
    case contacts
    case events
    case locationAlways
    case locationWhileUsing
    case microphone
    case motion
    case notifications
    case photos
    case reminders
    
    public var description: String {
        switch self {
        case .bluetooth:
            return "Bluetooth"
        case .camera:
            return "Camera"
        case .contacts:
            return "Contacts"
        case .events:
            return "Events"
        case .locationAlways:
            return "Location Always"
        case .locationWhileUsing:
            return "Location While Using"
        case .microphone:
            return "Microphone"
        case .motion:
            return "Core Motion"
        case .notifications:
            return "Notification"
        case .photos:
            return "Photos"
        case .reminders:
            return "Reminders"
        }
    }
}
