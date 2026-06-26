//
//  ReusableMessage.swift
//  trailweight
//
//  Created by Adam on 2026-06-26.
//

import Foundation
import SwiftUI

/**
 Reusable message with single confirm buttong
 - title: Title of the message
 - message: The optional message below the title
 - confirmString: Label for the confirm button
 - onConfirm: Invoked when the user taps the confirm button
 */

struct ReusableMessage: View {
    
    let title: String
    var message: String?
    let confirmString: String
    let onConfirm: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    /// Shorthand for current app colors
    private var colors: AppColors { AppColors.current(isDark: colorScheme == .dark) }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer().frame(height: 20)
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(colors.primary)
                    .multilineTextAlignment(.center)
                    .padding(20)
                
                if let message {
                    Text(message)
                        .font(.body)
                        .foregroundColor(colors.surface)
                        .multilineTextAlignment(.center)
                        .padding(10)
                }
                
                TrailWeightButton(
                    text: confirmString,
                    action: onConfirm,
                    icon: "checkmark"
                )
                .frame(maxWidth: .infinity * 0.6)
                .padding(10)
                
                Spacer().frame(height: 20)
            }
            .padding(20)
            .background(colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(radius: 6)
            .padding(.horizontal, 40)
        }
    }
}
