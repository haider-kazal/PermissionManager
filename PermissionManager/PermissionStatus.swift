//
//  PermissionStatus.swift
//  PermissionManager
//
//  Created by Haider Ali Kazal on 9/17/17.
//  Copyright © 2017 Haider Ali Kazal. All rights reserved.
//

public enum PermissionStatus: CustomStringConvertible {
    case authorized
    case denied
    case notDetermined
    case restricted
    
    public var description: String {
        switch self {
        case .authorized:
            return "User has authorized the permission request"
        case .denied:
            return "User has denied the permission request"
        case .notDetermined:
            return "Permission status is not determined"
        case .restricted:
            return "Permission is restricted by OS"
        }
    }
}
