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
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "page1" {
                NotificationsPage()
            } else if viewRouter.currentPage == "page2" {
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
        StarterView().environmentObject(ViewRouter())
    }
}
