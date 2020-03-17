//
//  ContentView.swift
//  just-hi
//
//  Created by Merunas Grincalaitis on 17/03/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let salutes = [
            "Have an amazing day today!",
            "Today is going to be amazing",
            "Enjoy every second because it's unique"
        ]
        let myNumber = Int.random(in: 0..<salutes.count)
        return VStack {
            Text("Hello")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40.0)
            Text(salutes[myNumber])
                .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
