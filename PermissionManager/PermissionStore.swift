//
//  PermissionStore.swift
//  PermissionManager
//
//  Created by Haider Ali Kazal on 9/17/17.
//  Copyright © 2017 Haider Ali Kazal. All rights reserved.
//

final class PermissionStore {
    private static var bundleIdentifier: String {
        return Bundle.main.bundleIdentifier ?? "xyz.kazal.framework.PermissionManager"
    }
    
    private static func generateKey(for type: PermissionType) -> String {
        return bundleIdentifier.appending(".\(type.description)")
    }
    
    static func saveStatus(of type: PermissionType, withValue value: PermissionStatus) {
        UserDefaults.standard.set(value.rawValue, forKey: generateKey(for: type))
    }
    
    static func getStatus(of type: PermissionType) -> PermissionStatus? {
        guard let status = UserDefaults.standard.string(forKey: generateKey(for: type)) else {
            return nil
        }
        
        return PermissionStatus(rawValue: status)
    }
}
