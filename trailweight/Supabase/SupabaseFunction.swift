//
//  AuthService.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import Foundation
import Supabase

private let supabase = SupabaseManager.shared.client

/// Signs in with email and password.
/// - Parameter email: The user's email address
/// - Parameter password: The user's password
/// - Returns: True on success, false on failure
func loginUser(email: String, password: String) async -> Bool {
    do {
        try await supabase.auth.signIn(email: email, password: password)
        return true
    } catch {
        print("Login failed: \(error.localizedDescription)")
        return false
    }
}

/// Signs out the current user.
func logoutUser() async {
    try? await supabase.auth.signOut()
}

/// Registers a new user with email and password.
/// - Parameter email: The user's email address
/// - Parameter password: The user's password
/// - Returns: Nil on success, error message on failure
func registerUser(email: String, password: String) async -> String? {
    do {
        try await supabase.auth.signUp(
            email: email,
            password: password,
            redirectTo: URL(string: "trailweight://confirm-signup")
        )
        return nil
    } catch {
        return error.localizedDescription
    }
}

/// Sends a password reset email to the provided address.
/// - Parameter email: The email address to send the reset link to
/// - Returns: True on success, false on failure
func resetPassword(email: String) async -> Bool {
    do {
        try await supabase.auth.resetPasswordForEmail(
            email,
            redirectTo: URL(string: "trailweight://reset-password")
        )
        return true
    } catch {
        print("Reset password failed: \(error.localizedDescription)")
        return false
    }
}

/// Updates the current user's password.
/// - Parameter newPassword: The new password to set
/// - Returns: True on success, false on failure
func updatePassword(newPassword: String) async -> Bool {
    do {
        try await supabase.auth.update(user: UserAttributes(password: newPassword))
        return true
    } catch {
        print("Update password failed: \(error.localizedDescription)")
        return false
    }
}

/// Deletes the current user's account, their lists, and signs them out.
/// - Returns: True on success, false on failure
func deleteUserAccount() async -> Bool {
    do {
        guard let userId = supabase.auth.currentUser?.id.uuidString else { return false }

        try await supabase
            .from("lists")
            .delete()
            .eq("user_id", value: userId)
            .execute()

        try await supabase.rpc("delete_user").execute()
        try await supabase.auth.signOut()
        return true
    } catch {
        print("Delete account failed: \(error.localizedDescription)")
        return false
    }
}
