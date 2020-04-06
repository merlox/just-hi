//
//  WelcomePage.swift
//  MinimalisticMotivation
//
//  Created by Merunas Grincalaitis on 05/04/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import Foundation
import SwiftUI

struct WelcomePage: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
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
        
        return VStack {
            Spacer()
            Text("Hello")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40.0)
                .frame(width: 300.0)
            Text(salutes[myNumber])
                .font(.headline)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                self.viewRouter.currentPage = "page1"
            }) {
                Text("Go to the notifications page")
                    .padding(20)
                    .frame(minWidth: 300)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage(viewRouter: ViewRouter())
    }
}
