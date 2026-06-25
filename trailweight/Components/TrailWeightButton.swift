//
//  TrailWeightButton.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import Foundation
import SwiftUI

enum TrailWeightButtonStyle {
    case primary, secondary, outlined, destructive
}

struct TrailWeightButton: View {
    var text: String? = nil
    let action: () -> Void
    var style: TrailWeightButtonStyle = .primary
    var icon: String? = nil
    var enabled: Bool = true
    
    private var contentColor: Color {
        switch style {
        case .primary:     return .white
        case .secondary:   return .white
        case .outlined:    return .accentColor
        case .destructive: return .white
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary: return .accentColor
        case .secondary: return .secondary
        case .outlined: return .clear
        case .destructive: return .red
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
                    .stroke(style == .outlined ? Color.accentColor : .clear, lineWidth: 1)
            )
            .shadow(
                color: (style == .outlined || !enabled) ? .clear : Color.black.opacity(0.15),
                radius: 4, y: 2
            )
        }
        .disabled(!enabled)
    }
}
