//
//  Storage.swift
//  MinimalisticMotivation
//
//  Created by Merunas Grincalaitis on 22/03/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import Foundation

let storageDefaultLocation = "myCustomAppData"

// 1. Inherit NSObject and NSCoding
class MyData: NSObject, NSCoding {
    enum Keys: String {
        case one = "shownInitialPermissionsMessage"
        case two = "notificationsAccepted" // Set in the page where you choose to activate or not
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
        let shownInitialPermissionsMessage = coder.decodeBool(forKey: Keys.one.rawValue)
        let notificationsAccepted = coder.decodeBool(forKey: Keys.two.rawValue)
        self.init(shownInitialPermissionsMessage, notificationsAccepted)
    }
}

struct Storage {
    func getInitialData() -> MyData? {
        return getData(storageDefaultLocation)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // 1
    func getData(_ fileName: String) -> MyData? {
        let fullPath = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fullPath)
            if let loadedStrings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? MyData {
                return loadedStrings
            }
        } catch {
            print("Couldn't read the stored data", error.localizedDescription)
        }
        return nil
    }
    
    // ObjectToSave is the data we want to save
    func setData(_ fileName: String, objectToSave: MyData) -> Bool {
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
    
    // The function that executes everything
    func example() {
        let result = getData(storageDefaultLocation) // 1
        
        if result != nil {
            print("A", result?.shownInitialPermissionsMessage ?? "abc")
            print("B", result?.notificationsAccepted ?? "abc")
        } else {
            let myData = MyData(false, false)
            myData.shownInitialPermissionsMessage = true
            myData.notificationsAccepted = true
            if setData(storageDefaultLocation, objectToSave: myData) {
                print("Data saved successfully")
            } else {
                print("Data not saved")
            }
        }
    }
    
    // Check if the initial permissions message is shown by checking if the variable is false or if getData returns nil
    // We only want to display the initial message once, when the app starts the first time after installation
    func appFirstStartSetVariables() {
        let result = getData(storageDefaultLocation)
        // Set the show permissions message to true
        if result == nil {
            let myData = MyData(false, false)
            if setData(storageDefaultLocation, objectToSave: myData) {
                print("Storage: initial storage setup successfully")
            } else {
                print("Storage error: initial storage setup not successfully")
            }
        }
    }
    
    // Set the state of the notifications message in the storage, the initial protective message state
    func setPageNotificationsState(setAsAccepted: Bool) {
        let result = getData(storageDefaultLocation)
        result?.notificationsAccepted = setAsAccepted
        if setData(storageDefaultLocation, objectToSave: result!) {
            print("Storage: notifications set as", setAsAccepted)
        } else {
            print("Storage error: notifications not set as", setAsAccepted)
        }
    }
}

// TODO watch a tutorial on unwrapping variables in Swift
// 1. When it first loads, check the saved data and retrieve the MyData
// 2. If it's saved, good
// 3. If it's not, create a new one and save it there.
