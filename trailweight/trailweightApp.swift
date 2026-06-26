//
//  trailweightApp.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import SwiftUI

@main
struct trailweightApp: App {
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(router)
        }
    }
}
