//
//  TrailWeightInputField.swift
//  trailweight
//
//  Created by Adam on 2026-06-25.
//

import SwiftUI

/// A reusable styled input field with label, password toggle, and error state support.
struct TrailWeightInputField<TrailingIcon: View>: View {
    
    /// The label displayed above the field
    let label: String
    
    /// The current value of the field
    @Binding var value: String

    var isPassword: Bool = false
    var isError: Bool = false
    var submitLabel: SubmitLabel = .done
    var onSubmit: (() -> Void)? = nil
    

    @ViewBuilder var trailingIcon: () -> TrailingIcon
    @Environment(\.colorScheme) var colorScheme
    
    /// Shorthand for current app colors
    private var colors: AppColors { AppColors.current(isDark: colorScheme == .dark) }

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            Text(label)
                .font(.caption)
                .foregroundColor(
                    isError ? colors.error :
                    isFocused ? colors.primary : .secondary
                )

            HStack {
                Group {
                    if isPassword {
                        SecureField("", text: $value)
                    } else {
                        TextField("", text: $value)
                    }
                }
                .focused($isFocused)
                .submitLabel(submitLabel)
                .onSubmit { onSubmit?() }
                .font(.system(size: 16))

                trailingIcon()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(colors.surfaceVariant.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isError ? colors.error :
                        isFocused ? colors.primary : Color.gray.opacity(0.4),
                        lineWidth: 1
                    )
            )
        }
    }
}


extension TrailWeightInputField where TrailingIcon == EmptyView {
    init(
        label: String,
        value: Binding<String>,
        isPassword: Bool = false,
        isError: Bool = false,
        submitLabel: SubmitLabel = .done,
        onSubmit: (() -> Void)? = nil
    ) {
        self.label = label
        self._value = value
        self.isPassword = isPassword
        self.isError = isError
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
        self.trailingIcon = { EmptyView() }
    }
}
