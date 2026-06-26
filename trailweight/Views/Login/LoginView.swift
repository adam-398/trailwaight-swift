//
//  LoginView.swift
//  trailweight
//
//  Created by Adam on 2026-06-26.
//

import Foundation
import SwiftUI

//login screen for app, handles email/password login, nav to register and new password views.

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var passwordVisible = false
    
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.accentColor.opacity(0.2), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer(minLength: 60)
                    
                    Text("Trail Weight")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .padding(.bottom, 8)
                    
                    Text("Build a light trip")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 32)
                    
                    VStack(spacing: 0) {
                        
                        TrailWeightInputField(
                            label: "Email",
                            value: $email
                        )
                        .padding(.vertical, 8)
                        .onChange(of: email) {  errorMessage = "" }
                        
                        TrailWeightInputField(
                            label: "Password",
                            value: $password,
                            isPassword: !passwordVisible
                        ) {
                            Button {
                                passwordVisible.toggle()
                            } label: {
                                Image(systemName: passwordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.secondary)
                            }
                        }
                            .padding(.vertical, 8)
                            .onChange(of: password) { errorMessage = "" }
                        
                        TrailWeightButton(text: isLoading ? "Logging in..." : "Login") {
                            guard !isLoading else { return }
                            Task {
                                isLoading = true
                                let success = await loginUser(email: email, password: password)
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
                    .padding(24)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(radius: 4)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.top, 16)
                    }
                
                    TrailWeightButton(text: "Register", action: {
                        router.navigate(to: .register)
                    }, style: .secondary)
                    .padding(.top, 24)
                    .frame(height: 50)
                    
                    TrailWeightButton(text: "Forgot password?", action: {
                        router.navigate(to: .forgotPassword)
                    })
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.accentColor)
                    .padding(.top, 24)
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}


#Preview {
    LoginView()
        .environmentObject(Router())
}
