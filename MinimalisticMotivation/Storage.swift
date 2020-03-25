//
//  Storage.swift
//  MinimalisticMotivation
//
//  Created by Merunas Grincalaitis on 22/03/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import Foundation

// 1. Inherit NSObject and NSCoding
class MyData: NSObject, NSCoding {
    enum Keys: String {
        case one = "shownInitialPermissionsMessage"
        case two = "notificationsAccepted"
    }
    // 2. Setup variables
    var shownInitialPermissionsMessage: Bool
    var notificationsAccepted: Bool

    // 3. Setup init constructor
    init(_ shownInitialPermissionsMessage: Bool, _ notificationsAccepted: Bool) {
        self.shownInitialPermissionsMessage = shownInitialPermissionsMessage
        self.notificationsAccepted = notificationsAccepted
    }

    // 4. Setup the encoder to parse data
    func encode(with coder: NSCoder) {
        coder.encode(shownInitialPermissionsMessage, forKey: Keys.one.rawValue)
        coder.encode(notificationsAccepted, forKey: Keys.two.rawValue)
    }

    required convenience init?(coder: NSCoder) {
        let shownInitialPermissionsMessage = coder.decodeBool(forKey: "shownInitialPermissionsMessage")
        let notificationsAccepted = coder.decodeBool(forKey: "notificationsAccepted")
        self.init(shownInitialPermissionsMessage, notificationsAccepted)
    }
}

// Utilities to save and retrieve data
struct Utilities {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // 1
    func getData() -> MyData? {
        let fileName = "myUserData"
        let fullPath = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fullPath)
            if let loadedStrings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? MyData {
                return loadedStrings
            }
        } catch {
            print("Couldn't read the stored data")
        }
        return nil
    }
    
    // ObjectToSave is the data we want to save
    func setData(objectToSave: MyData) -> Bool {
        let fileName = "myUserData"
        let fullPath = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: objectToSave, requiringSecureCoding: false)
            try data.write(to: fullPath)
            return true
        } catch {
            print("Error saving file")
        }
        return false
    }
}

struct Storage {
    // The function that executes everything
    func example() {
        let myUtilities = Utilities()
        let result = myUtilities.getData() // 1
        
        if result != nil {
            print("A", result?.shownInitialPermissionsMessage ?? "abc")
            print("B", result?.notificationsAccepted ?? "abc")
        } else {
            let myData = MyData(false, false)
            myData.shownInitialPermissionsMessage = true
            myData.notificationsAccepted = true
            if myUtilities.setData(objectToSave: myData) {
                print("Data saved successfully")
            } else {
                print("Data NOT saved")
            }
        }
    }
}

// 1. When it first loads, check the saved data and retrieve the MyData
// 2. If it's saved, good
// 3. If it's not, create a new one and save it there.
