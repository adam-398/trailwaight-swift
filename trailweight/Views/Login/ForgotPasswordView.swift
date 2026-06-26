//
//  ForgotPasswordView.swift
//  trailweight
//
//  Created by Adam on 2026-06-26.
//

import Foundation
import SwiftUI

///Forgot password screen for the app
struct ForgotPasswordView: View {
    
    @State private var email = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    @EnvironmentObject var router: Router
    @Environment(\.colorScheme) var colorScheme
    
    /// Shorthand for current app colors
    private var colors: AppColors { AppColors.current(isDark: colorScheme == .dark) }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [colors.primary.opacity(0.2), colors.background],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer(minLength: 60)
                    
                    // App title
                    Text("Trail Weight")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(colors.primary)
                        .padding(.bottom, 8)
                    
                    //Subtitle
                    Text("Enter your email to reset your password")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 32)
                    
                    VStackLayout(spacing: 0) {
                        
                        TrailWeightInputField(
                            label: "Email",
                            value: $email
                        )
                        .padding(.vertical, 8)
                        .onChange(of: email) { errorMessage = "" }
                        
                        
                        TrailWeightButton(text: isLoading ? "Resetting..." : "Reset password") {
                            guard !isLoading else { return }
                            Task {
                                isLoading = true
                                let success = await resetPassword(email: email)
                                isLoading = false
                                if success {
                                    router.navigate(to: .landing)
                                } else {
                                    errorMessage = "Invalid email or password"
                                }
                            }
                        }
                        .padding(.top, 16)
                        .frame(height: 50)
                    }
                }
            }
        }
    }
}
