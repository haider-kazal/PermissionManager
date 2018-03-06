//
//  PermissionRequest.swift
//  PermissionManager
//
//  Created by Haider Ali Kazal on 9/18/17.
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

public typealias PermissionRequestCompletion = ((_ status: PermissionStatus?) -> Void)?

protocol PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion)
}

extension BluetoothPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        completion?(.notDetermined)
    }
}

extension CameraPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            let status: PermissionStatus = granted ? .authorized : .denied
            completion?(status)
        }
    }
}

extension ContactPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        if #available(iOS 9.0, *) {
            self.contactStore.requestAccess(for: .contacts) { (granted, error) in
                guard error == nil else {
                    completion?(self.status)
                    return
                }
                
                let requestStatus: PermissionStatus = granted ? .authorized : .denied
                completion?(requestStatus)
            }
        } else {
            ABAddressBookRequestAccessWithCompletion(nil) { (isGranted, error) in
                isGranted ? completion?(.authorized): completion?(.denied)
            }
        }
        
    }
}

extension EventPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { (granted, error) in
            guard error == nil else {
                completion?(.restricted)
                return
            }
            
            let requestStatus: PermissionStatus = granted ? .authorized : .denied
            completion?(requestStatus)
        }
    }
}

extension LocationAlwaysPermission: PermissionRequest, CLLocationManagerDelegate {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        self.locationManager.requestAlwaysAuthorization()
        self.completion = completion
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            completion?(.authorized)
        case .authorizedWhenInUse,
             .denied:
            completion?(.denied)
        case .notDetermined:
            completion?(.notDetermined)
        case .restricted:
            completion?(.restricted)
        }
    }
}

extension LocationWhileUsingPermission: PermissionRequest, CLLocationManagerDelegate {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        self.locationManager.requestWhenInUseAuthorization()
        self.completion = completion
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse:
            completion?(.authorized)
        case .denied:
            completion?(.denied)
        case .notDetermined:
            completion?(.notDetermined)
        case .restricted:
            completion?(.restricted)
        }
    }
}

extension MicrophonePermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            let requestStatus: PermissionStatus = granted ? .authorized : .denied
            completion?(requestStatus)
        }
    }
}

extension MotionPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        completion?(.notDetermined)
    }
}

extension NotificationPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        if #available(iOS 10.0, *) {
            let authorizationOptions: UNAuthorizationOptions = [ .alert, .badge, .sound ]
            UNUserNotificationCenter.current().requestAuthorization(options: authorizationOptions) { (granted, error) in
                guard error == nil else {
                    completion?(.restricted)
                    return
                }
                
                let requestStatus: PermissionStatus = granted ? .authorized : .denied
                completion?(requestStatus)
            }
        } else {
            let notificationTypes: UIUserNotificationType = [ .alert, .badge, .sound ]
            let settings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            completion?(nil) // Still has issue, no callback to know status
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}

extension PhotosPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:       completion?(.authorized)
            case .denied:           completion?(.denied)
            case .notDetermined:    completion?(.notDetermined)
            case .restricted:       completion?(.restricted)
            }
        }
    }
}

extension ReminderPermission: PermissionRequest {
    func requestPermission(completion: PermissionRequestCompletion) {
        guard status == .notDetermined else {
            completion?(status)
            return
        }
        
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .reminder) { (granted, error) in
            guard error == nil else {
                completion?(.restricted)
                return
            }
            
            let requestStatus: PermissionStatus = granted ? .authorized : .denied
            completion?(requestStatus)
        }
    }
}
