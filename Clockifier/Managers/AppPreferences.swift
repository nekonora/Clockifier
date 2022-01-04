//
//  AppPreferences.swift
//  AppPreferences
//
//  Created by Filippo Zaffoni on 01/09/21.
//  Copyright © 2021 Filippo Zaffoni. All rights reserved.
//

import Foundation
import KeychainAccess
import LogManager

public protocol PlistCompatible { }

// MARK: - UserDefaults Compatibile Types
extension String: PlistCompatible { }
extension Int: PlistCompatible { }
extension Double: PlistCompatible { }
extension Float: PlistCompatible { }
extension Bool: PlistCompatible { }
extension Date: PlistCompatible { }
extension Data: PlistCompatible { }
extension Array: PlistCompatible where Element: PlistCompatible { }
extension Dictionary: PlistCompatible where Key: PlistCompatible, Value: PlistCompatible { }

final class AppPreferences {
    
    // MARK: - Keys
    enum StorageKey: String, CaseIterable {
        case completedOnboarding
        case lastUsedProjectId
    }
    
    // MARK: - Properties
    /// User completed onboarding at least once
    @Storage<Bool>(key: .completedOnboarding, defaultValue: false)
    static var completedOnboarding: Bool
    
    @OptionalStorage<String>(key: .lastUsedProjectId)
    static var lastUsedProjectId: String?
    
    // MARK: - Methods
    static func removeData(for keys: Set<StorageKey>) {
        if keys.contains(.completedOnboarding) { completedOnboarding = false }
        if keys.contains(.lastUsedProjectId) { lastUsedProjectId = nil }
    }
    
    static func reset() {
        removeData(for: Set(StorageKey.allCases))
    }
}

final class AppSecureKeys {
    
    // MARK: - Keys
    enum SecureKey: String, CaseIterable {
        case clockifyAppToken
        case harvestToken
    }
    
    /// Clockify app token
    @SecureStorage(key: .clockifyAppToken)
    static var clockifyAppToken: String?
    
    /// Harvest app token
    @SecureStorage(key: .harvestToken)
    static var harvestToken: String?
    
    // MARK: - Methods
    static func removeData(for keys: Set<SecureKey>) {
        if keys.contains(.clockifyAppToken) { clockifyAppToken = nil }
        if keys.contains(.harvestToken) { harvestToken = nil }
    }
    
    static func reset() {
        removeData(for: Set(SecureKey.allCases))
    }
}

// MARK: - Storage property wrappers
@propertyWrapper
struct Storage<Value: PlistCompatible> {
    
    let key: AppPreferences.StorageKey
    let defaultValue: Value
    let storage: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            storage.object(forKey: key.rawValue) as? Value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key.rawValue)
            storage.synchronize()
        }
    }
}

@propertyWrapper
struct OptionalStorage<Value: PlistCompatible> {
    
    let key: AppPreferences.StorageKey
    let storage: UserDefaults = .standard
    
    var wrappedValue: Value? {
        get {
            storage.object(forKey: key.rawValue) as? Value
        }
        set {
            storage.set(newValue, forKey: key.rawValue)
            storage.synchronize()
        }
    }
}

@propertyWrapper
struct SecureStorage {
    
    let key: AppSecureKeys.SecureKey
    let storage: Keychain = Keychain(service: Constants.App.keychainBundle)
    
    var wrappedValue: String? {
        get {
            do {
                return try storage.getString(key.rawValue)
            } catch {
                LogManager.shared.logMessage(source: .storage,
                                             message: "Keychain failed to get value for \(key.rawValue)\n\(error.localizedDescription)")
                return nil
            }
        }
        set {
            if let value = newValue {
                do {
                    try storage.set(value, key: key.rawValue)
                } catch {
                    LogManager.shared.logMessage(source: .storage,
                                                 message: "Keychain failed to set \(value) in \(key.rawValue)\n\(error.localizedDescription)")
                }
            } else {
                do {
                    try storage.remove(key.rawValue)
                } catch let error {
                    LogManager.shared.logMessage(source: .storage,
                                                 message: "Keychain failed to set \(newValue ?? "nil") in \(key.rawValue)\n\(error.localizedDescription)")
                }
            }
        }
    }
}
