//
//  Router.swift
//  trailweight
//
//  Created by Adam on 2026-06-26.
//

import Foundation
import SwiftUI
import Combine

///Defines navigation routes in the app

enum Route: Hashable {
    case login
    case register
    case landing
    case forgotPassword
    case resetPassword
    case gearList(id: String)
    case settings
}

///manages navigation state across the app
class Router: ObservableObject {
    
    ///The current navigation path
    @Published var path = NavigationPath()
    
    ///The current root screen
    @Published var root: Route = .login
    
    ///Navigate to a new screen
    /// - Parameter route: The destination route
    func naviagte(to route: Route) {
        path.append(route)
    }
    
    ///Go back one screen
    func goBack() {
        path.removeLast()
    }
    
    ///Go back to the root screen
    func goBackToRoot() {
        path.removeLast(path.count)
    }
}
