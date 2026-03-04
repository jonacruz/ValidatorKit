//
//  ComparatorRules.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 03/03/26.
//

import Foundation

/// Validates that a value is strictly greater than a reference value.
///
/// Supports both static values and dynamic field closures for cross-field comparisons:
/// ```swift
/// // Static
/// Validator<Int>().add(GreaterThanRule(than: 18))
///
/// // Dynamic (e.g. endDate must be after startDate)
/// Validator<Date>().add(GreaterThanRule(than: { self.startDate }, message: "End date must be after start date"))
/// ```
public struct GreaterThanRule<Value: Comparable>: ValidationRule {
    public var errorMessage: String
    private let getReferenceValue: () -> Value

    public init(than reference: Value, message: String? = nil) {
        self.getReferenceValue = { reference }
        self.errorMessage = message ?? "Value must be greater than \(reference)"
    }

    public init(than reference: @escaping () -> Value, message: String = "Value must be greater than the reference") {
        self.getReferenceValue = reference
        self.errorMessage = message
    }

    public func validate(_ value: Value) -> Bool {
        value > getReferenceValue()
    }
}

/// Validates that a value is strictly less than a reference value.
///
/// Supports both static values and dynamic field closures for cross-field comparisons:
/// ```swift
/// // Static
/// Validator<Int>().add(LessThanRule(than: 100))
///
/// // Dynamic
/// Validator<Date>().add(LessThanRule(than: { self.deadline }, message: "Must be before the deadline"))
/// ```
public struct LessThanRule<Value: Comparable>: ValidationRule {
    public var errorMessage: String
    private let getReferenceValue: () -> Value

    public init(than reference: Value, message: String? = nil) {
        self.getReferenceValue = { reference }
        self.errorMessage = message ?? "Value must be less than \(reference)"
    }

    public init(than reference: @escaping () -> Value, message: String = "Value must be less than the reference") {
        self.getReferenceValue = reference
        self.errorMessage = message
    }

    public func validate(_ value: Value) -> Bool {
        value < getReferenceValue()
    }
}
