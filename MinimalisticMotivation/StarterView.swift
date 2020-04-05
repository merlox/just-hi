//
//  StarterView.swift
//  MinimalisticMotivation
//
//  Created by Merunas Grincalaitis on 05/04/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import SwiftUI
import Foundation

enum AppScreen: String {
    case enableNotificationsPage = "enableNotifications"
    case welcomeMotivationPage = "welcomeMotivationPage"
    case articlesPage = "articlesPage"
}
var currentScreen: AppScreen = AppScreen.enableNotificationsPage
let storage = Storage()
let utilities = MyUtilities()

struct StarterView: View {
    @State var page = "page2"
    
    var body: some View {
        VStack {
            if page == "page1" {
                NotificationsPage()
            } else {
                WelcomePage()
            }
        }
    }
    
    init() {
        storage.appFirstStartSetVariables()
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
    }
}
