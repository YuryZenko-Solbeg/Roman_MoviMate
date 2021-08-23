//
//  UserDefaultManager.swift
//  MoviMate
//
//  Created by Roman Alikevich on 16.08.21.
//

import UIKit

protocol WareHouseManager {
    
    func updateStorage(_ dictionary: [String: Any])
    
    func getValueFromStorage(key: String) -> Any?
}

final class UserDefaultManager: WareHouseManager {
    
    static var shared = UserDefaultManager()

    private let storage = UserDefaults.standard
    
    static let defaultSystemLanguge = "en"
    static let systemRussianLanguge = "ru"
    private static let defaultPixelSize = 200

    private var language: String?
    private var pixelSize: Int?
    
    enum WareHouseType: String {
        case language = "lan"
        case pixelSize = "pixel_size"
    }
    
    private init() {
        guard let _ = getValueFromStorage(key: WareHouseType.language.rawValue) as? String else {
            updateStorage([WareHouseType.language.rawValue:UserDefaultManager.defaultSystemLanguge, WareHouseType.pixelSize.rawValue:UserDefaultManager.defaultPixelSize])
            return
        }
        language = getValueFromStorage(key: WareHouseType.language.rawValue) as? String
        pixelSize = getValueFromStorage(key: WareHouseType.pixelSize.rawValue) as? Int
    }
    
    func updateStorage(_ dictionary: [String: Any]) {
        
        dictionary.forEach { (key, value) in
            
            storage.setValue(value, forKey: key)
            
            if key == WareHouseType.language.rawValue {
                
                language = value as? String
            } else if key == WareHouseType.pixelSize.rawValue {
                
                pixelSize = value as? Int
            }
        }
    }
    
    func getValueFromStorage(key: String) -> Any? {
        return storage.object(forKey: key)
    }
    
    func getLanguage() -> String? {
        return language
    }
    
    func getPixelSize() -> Int? {
        return pixelSize
    }
}
