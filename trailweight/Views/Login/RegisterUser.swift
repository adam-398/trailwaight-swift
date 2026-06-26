import SwiftUI

struct RegisterUser: View {
    @EnvironmentObject var router: Router
    @Environment(\.colorScheme) var colorScheme

    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var isLoading = false
    @State private var showSuccessMessage = false

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
                    Spacer().frame(height: 60)

                    Text("Trail Weight")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(colors.primary)
                        .padding(.bottom, 8)

                    Text("Create an account to start tracking")
                        .font(.body)
                        .foregroundColor(colors.secondary)
                        .padding(.bottom, 32)

                    VStack(spacing: 0) {
                        TrailWeightInputField(
                            label: "Email",
                            value: $email
                        )
                        TrailWeightInputField(
                            label: "Password",
                            value: $password,
                            isPassword: true
                        )
                        TrailWeightInputField(
                            label: "Confirm password",
                            value: $confirmPassword,
                            isPassword: true
                        )

                        TrailWeightButton(
                            text: isLoading ? "Registering..." : "Create account"
                        ) {
                            guard !isLoading else { return }
                            errorMessage = ""
                            guard password.count >= 8 else {
                                errorMessage = "Password must be at least 8 characters"
                                return
                            }
                            guard password == confirmPassword else {
                                errorMessage = "Passwords do not match"
                                return
                            }
                            Task {
                                isLoading = true
                                let error = await registerUser(email: email, password: password)
                                isLoading = false
                                if error == nil {
                                    showSuccessMessage = true
                                } else {
                                    errorMessage = error ?? "Error creating account, please try again"
                                }
                            }
                        }
                        
                        .padding(.top, 16)
                        .frame(height: 50)
                    }
                    .padding(24)
                    .background(colors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 24)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(colors.error)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.top, 16)
                            .padding(.horizontal, 24)
                    }

                    Button {
                        router.goBack()
                    } label: {
                        Text("Already have an account? Login")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(colors.primary)
                    }
                    .padding(.top, 24)

                    Spacer().frame(height: 40)
                }
            }
            .scrollDismissesKeyboard(.interactively)

            if showSuccessMessage {
                ReusableMessage(
                    title: "Success",
                    message: "Account created successfully. Please check your email for a confirmation link.",
                    confirmString: "OK",
                    onConfirm: {
                        router.navigate(to: .login)
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterUser()
        .environmentObject(Router())
}
