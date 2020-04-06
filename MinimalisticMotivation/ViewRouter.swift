//
//  ViewRouter.swift
//  MinimalisticMotivation
//
//  Created by Merunas Grincalaitis on 06/04/2020.
//  Copyright © 2020 Merunas Grincalaitis. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ViewRouter: ObservableObject {
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    var currentPage: String = "page1" {
        didSet {
            objectWillChange.send(self)
        }
    }
}

struct ViewRouter_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
