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
    
    /// Whether the field should obscure input (password)
    var isPassword: Bool = false
    
    /// Whether the field is in an error state
    var isError: Bool = false
    
    /// The return key label
    var submitLabel: SubmitLabel = .done
    
    /// Action to perform when the user hits return
    var onSubmit: (() -> Void)? = nil
    
    /// Optional trailing icon (e.g. password visibility toggle)
    @ViewBuilder var trailingIcon: () -> TrailingIcon

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(
                    isError ? .red :
                    isFocused ? .accentColor : .secondary
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
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isError ? Color.red :
                        isFocused ? Color.accentColor : Color.gray.opacity(0.4),
                        lineWidth: 1
                    )
            )
        }
    }
}

/// Convenience init for fields with no trailing icon
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
