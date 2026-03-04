//
//  ConditionalRule.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 03/03/26.
//

import Foundation

/// Wraps another rule and only applies it when a condition is met.
/// If the condition is false, validation passes automatically.
///
/// ```swift
/// // Only validate email format if the field is not empty
/// Validator<String>().add(ConditionalRule(when: { !$0.isEmpty }, apply: EmailRule()))
///
/// // Only require a minimum age if the user checks "I have a driver's license"
/// Validator<Int>().add(ConditionalRule(when: { self.hasLicense }, apply: MinValueRule(18)))
/// ```
public struct ConditionalRule<Value>: ValidationRule {
    public var errorMessage: String
    private let condition: (Value) -> Bool
    private let wrappedValidate: (Value) -> Bool

    public init<Rule: ValidationRule>(
        when condition: @escaping (Value) -> Bool,
        apply rule: Rule,
        message: String? = nil
    ) where Rule.Value == Value {
        self.condition = condition
        self.wrappedValidate = { rule.validate($0) }
        self.errorMessage = message ?? rule.errorMessage
    }

    public func validate(_ value: Value) -> Bool {
        guard condition(value) else { return true }
        return wrappedValidate(value)
    }
}
