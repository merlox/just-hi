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
    var currentPage: String = "page2" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
