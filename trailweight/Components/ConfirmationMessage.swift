//
//  ConfirmationMessage.swift
//  trailweight
//
//  Created by Adam on 2026-06-26.
//

import Foundation
import SwiftUI

struct ConfirmationMessage: View {
    
    let title: String
    var message: String? = nil
    let confirmString: String
    let dismissString: String
    let onConfirm: () -> Void
    let onDismiss: () -> Void
    var confirmIcon: String? = nil
    var dismissIcon: String? = nil
    var confirmStyle: TrailWeightButtonStyle = .primary
    
    @Environment(\.colorScheme) var colorScheme
    
    /// Shorthand for current app colors
    private var colors: AppColors { AppColors.current(isDark: colorScheme == .dark) }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(colors.primary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                
                if let message {
                    Text(message)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                }
                
                HStack(spacing: 16) {
                    TrailWeightButton(
                        text: dismissString,
                        action: onDismiss,
                        style: .outlined,
                        icon: dismissIcon
                    )
                    
                    TrailWeightButton(
                        text: confirmString,
                        action: onConfirm,
                        style: confirmStyle,
                        icon: confirmIcon
                    )
                }
                
            }
        }
    }
}


#Preview {
    ConfirmationMessage(
        title: "Are you sure?",
        message: "This action cannot be undone",
        confirmString: "confirm",
        dismissString: "Dismiss",
        onConfirm: {},
        onDismiss: {},
    )
}
