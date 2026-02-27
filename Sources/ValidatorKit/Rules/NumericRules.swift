//
//  NumericRules.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import Foundation

public struct MinValueRule<Value: Comparable>: ValidationRule {
    public var errorMessage: String
    let min: Value
    
    public init(_ min: Value, message: String? = nil) {
        self.min = min
        self.errorMessage = message ?? "Value must be at least \(min)"
    }
    
    public func validate(_ value: Value) -> Bool {
        value >= min
    }
}

public struct MaxValueRule<Value: Comparable>: ValidationRule {
    public var errorMessage: String
    let max: Value
    
    public init(_ max: Value, message: String? = nil) {
        self.max = max
        self.errorMessage = message ?? "Value must be at most \(max)"
    }
    
    public func validate(_ value: Value) -> Bool {
        value <= max
    }
}

public struct RangeRule<Value: Comparable>: ValidationRule {
    public var errorMessage: String
    let min: Value, max: Value
    
    public init(_ min: Value, _ max: Value, message: String? = nil) {
        self.min = min
        self.max = max
        self.errorMessage = message ?? "Value must be between \(min) and \(max)"
    }
    
    public func validate(_ value: Value) -> Bool {
        value >= min && value <= max
    }
}
