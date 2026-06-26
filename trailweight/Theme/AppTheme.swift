//
//  AppTheme.swift
//  trailweight
//
//  Created by Adam on 2026-06-26.
//

import SwiftUI

// MARK: - Colors

extension Color {
    
    // MARK: Light Mode
    static let twBackgroundLight      = Color(hex: "FDFBF7")
    static let twSurfaceLight         = Color(hex: "F6F2EB")
    static let twSurfaceVariantLight  = Color(hex: "EFE8D8")
    static let twPrimaryLight         = Color(hex: "5A6B39")
    static let twOnPrimaryLight       = Color(hex: "FFFFFF")
    static let twSecondaryLight       = Color(hex: "C9642D")
    static let twOnSecondaryLight     = Color(hex: "FFFFFF")
    static let twTertiaryLight        = Color(hex: "1A344F")
    static let twOnTertiaryLight      = Color(hex: "FFFFFF")
    static let twErrorLight           = Color(hex: "B3261E")

    // MARK: Dark Mode
    static let twBackgroundDark       = Color(hex: "151812")
    static let twSurfaceDark          = Color(hex: "1D211A")
    static let twSurfaceVariantDark   = Color(hex: "2A2E26")
    static let twPrimaryDark          = Color(hex: "B3C68D")
    static let twOnPrimaryDark        = Color(hex: "2A301D")
    static let twSecondaryDark        = Color(hex: "D4855A")
    static let twOnSecondaryDark      = Color(hex: "331D11")
    static let twTertiaryDark         = Color(hex: "7D99B5")
    static let twOnTertiaryDark       = Color(hex: "0F1B26")
    static let twErrorDark            = Color(hex: "F2B8B5")

    // MARK: Hex initializer
    /// Creates a Color from a hex string e.g. "5A6B39"
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue >> 16) & 0xFF) / 255.0
        let g = Double((rgbValue >> 8) & 0xFF) / 255.0
        let b = Double(rgbValue & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Environment Key for color scheme access

struct AppColors {
    let background: Color
    let surface: Color
    let surfaceVariant: Color
    let primary: Color
    let onPrimary: Color
    let secondary: Color
    let onSecondary: Color
    let tertiary: Color
    let onTertiary: Color
    let error: Color

    static func current(isDark: Bool) -> AppColors {
        if isDark {
            return AppColors(
                background:     .twBackgroundDark,
                surface:        .twSurfaceDark,
                surfaceVariant: .twSurfaceVariantDark,
                primary:        .twPrimaryDark,
                onPrimary:      .twOnPrimaryDark,
                secondary:      .twSecondaryDark,
                onSecondary:    .twOnSecondaryDark,
                tertiary:       .twTertiaryDark,
                onTertiary:     .twOnTertiaryDark,
                error:          .twErrorDark
            )
        } else {
            return AppColors(
                background:     .twBackgroundLight,
                surface:        .twSurfaceLight,
                surfaceVariant: .twSurfaceVariantLight,
                primary:        .twPrimaryLight,
                onPrimary:      .twOnPrimaryLight,
                secondary:      .twSecondaryLight,
                onSecondary:    .twOnSecondaryLight,
                tertiary:       .twTertiaryLight,
                onTertiary:     .twOnTertiaryLight,
                error:          .twErrorLight
            )
        }
    }
}
