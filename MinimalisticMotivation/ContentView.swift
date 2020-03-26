//
//  ContentView.swift
//  just-hi
//
//  Created by Merunas Grincalaitis on 17/03/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import SwiftUI

let storage = Storage()
var myData: MyData? = storage.getInitialData()
var utilities: MyUtilities? = nil

struct ContentView: View {
    var body: some View {
        setup()
        return initialScreen()
    }
    
    func setup() {
        if myData == nil {
            print("Data not setup")
            utilities = MyUtilities(false, false)
        } else {
            print("Initial data 1", myData?.shownInitialPermissionsMessage ?? "a")
            print("Initial data 2", myData?.notificationsAccepted ?? "b")
            utilities = MyUtilities(myData?.shownInitialPermissionsMessage, myData?.notificationsAccepted)
        }
    }
    
    func initialScreen() -> AnyView {
        return AnyView(VStack {
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
                utilities!.askNotificationsPermission()
            }) {
                Text("Enable notifications")
                    .padding(20)
                    .frame(minWidth: 300)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Button(action: {
                let stor = Storage()
                stor.example()
            }) {
                Text("I don't want to be notified")
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .frame(minWidth: 300)
            }
            Spacer()
        })
    }
    
    func homeScreen() -> AnyView {
        let salutes = [
            "Have an amazing day today!",
            "Today is going to be amazing.",
            "Enjoy every second because it's unique.",
            "Think long term to build permanent happiness.",
            "Enjoy the daily actions because they are unique.",
            "Continue learning 10 minutes everyday to create massive change in your life.",
            "This is the day you make a difference.",
            "Your tomorrow self will thank you for today's sacrifices.",
            "Progress never ends.",
        ]
        let myNumber = Int.random(in: 0..<salutes.count)
        return AnyView(VStack {
            Text("Hello")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40.0)
                .frame(width: 300.0)
            Text(salutes[myNumber])
                .font(.headline)
                .multilineTextAlignment(.center)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
