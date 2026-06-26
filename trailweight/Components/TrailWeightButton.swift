//
//  TrailWeightButton.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import SwiftUI

/// Defines the visual style of a TrailWeightButton
enum TrailWeightButtonStyle {
    /// Filled button with primary color background
    case primary
    /// Filled button with secondary color background
    case secondary
    /// Transparent button with primary color border
    case outlined
    /// Filled button with error color background for destructive actions
    case destructive
}

/// A reusable button component with multiple styles.
struct TrailWeightButton: View {
    
    var text: String? = nil
    let action: () -> Void
    var style: TrailWeightButtonStyle = .primary
    var icon: String? = nil
    var enabled: Bool = true
    
    /// Current color scheme for dark/light mode
    @Environment(\.colorScheme) var colorScheme
    

    private var colors: AppColors { AppColors.current(isDark: colorScheme == .dark) }

    private var contentColor: Color {
        switch style {
        case .primary:     return colors.onPrimary
        case .secondary:   return colors.onSecondary
        case .outlined:    return colors.primary
        case .destructive: return colors.onPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary:     return colors.primary
        case .secondary:   return colors.secondary
        case .outlined:    return .clear
        case .destructive: return colors.error
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                }
                if let text {
                    Text(text)
                        .font(.callout)
                        .fontWeight(.medium)
                }
            }
            .foregroundColor(enabled ? contentColor : .secondary)
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(enabled ? backgroundColor : Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style == .outlined ? colors.primary : .clear, lineWidth: 1)
            )
            .shadow(
                color: (style == .outlined || !enabled) ? .clear : Color.black.opacity(0.15),
                radius: 4, y: 2
            )
        }
        .disabled(!enabled)
    }
}
