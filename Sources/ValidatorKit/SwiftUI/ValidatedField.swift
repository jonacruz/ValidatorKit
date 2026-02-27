//
//  File.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
public struct ValidatedField: View {
    let title: String
    @Binding var text: String
    let validator: Validator<String>
    
    @State private var errorMessage: String? = nil
    @State private var isDirty: Bool = false
    
    public init(_ title: String, text: Binding<String>, validator: Validator<String>) {
        self.title = title
        self._text = text
        self.validator = validator
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(title, text: $text)
                .textFieldStyle(.roundedBorder)
                .onChange(of: text) { newValue in
                    if isDirty {
                        errorMessage = validator.validate(newValue).firstError
                    }
                }
                .onSubmit {
                    isDirty = true
                    errorMessage = validator.validate(text).firstError
                }
            
            if let error = errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }
}
