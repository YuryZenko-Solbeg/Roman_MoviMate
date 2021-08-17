//
//  UserDefaultManager.swift
//  MoviMate
//
//  Created by Roman Alikevich on 16.08.21.
//

import UIKit

protocol WareHouseManager {
    
    associatedtype T
    
    func setValueToStorage(value: T, key: String)
    func getValueToStorage(key: String) -> T?
}

final class UserDefaultManager<T>: WareHouseManager {
   
//    static var shared = UserDefaultManager<T>()

    private let storage = UserDefaults.standard
    
    func setValueToStorage(value: T, key: String) {
        storage.setValue(value, forKey: key)
    }
    
    func getValueToStorage(key: String) -> T? {
        return storage.object(forKey: key) as? T
    }
}
