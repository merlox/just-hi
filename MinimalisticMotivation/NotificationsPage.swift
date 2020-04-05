//
//  NotificationsPage.swift
//  MinimalisticMotivation
//
//  Created by Merunas Grincalaitis on 05/04/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import SwiftUI
import Foundation

struct NotificationsPage: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Receive a unique motivational message straight to your phone notifications at 8am everyday. You can disable this feature later on.")
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 300)
                .padding(50)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Button(action: {
                utilities.askNotificationsPermission { (granted: Bool) -> Void in
                    storage.setPageNotificationsState(setAsAccepted: granted)
                    currentScreen = AppScreen.welcomeMotivationPage
                }
            }) {
                Text("Enable notifications")
                    .padding(20)
                    .frame(minWidth: 300)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Button(action: {
                storage.setPageNotificationsState(setAsAccepted: false)
                currentScreen = AppScreen.welcomeMotivationPage
            }) {
                Text("I don't want to be notified")
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .frame(minWidth: 300)
            }
            Spacer()
        }
    }
}

struct NotificationsPage_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsPage()
    }
}
