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
    @AppStorage("isDarkMode") var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(router)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
