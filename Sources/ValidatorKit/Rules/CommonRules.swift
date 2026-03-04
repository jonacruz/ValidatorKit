//
//  CommonRules.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import Foundation

public struct MatchRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    let valueToMath: String
    
    public init(_ valueToMath: String, message: String = "Does not match") {
        self.errorMessage = message
        self.valueToMath = valueToMath
    }
    
    public func validate(_ value: String) -> Bool {
        value == valueToMath
    }
}

public struct URLRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    
    public init(message: String = "Is not a valid URL") {
        self.errorMessage = message
    }
    
    public func validate(_ value: String) -> Bool {
        guard let url = URL(string: value) else { return false }
        return url.scheme == "http" || url.scheme == "https"
    }
}

public struct PhoneRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String

    public init(message: String = "Is not a valid phone number") {
        self.errorMessage = message
    }

    public func validate(_ value: String) -> Bool {
        let regex = #"^\+?[0-9]{7,15}$"#
        return value.range(of: regex, options: .regularExpression) != nil
    }
}

public struct CreditCardRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String

    public init(message: String = "Invalid credit card number") {
        self.errorMessage = message
    }

    public func validate(_ value: String) -> Bool {
        let digits = value.filter { $0.isNumber }
        guard (13...19).contains(digits.count) else { return false }

        var sum = 0
        for (index, char) in digits.reversed().enumerated() {
            guard let digit = char.wholeNumberValue else { return false }
            if index % 2 == 1 {
                let doubled = digit * 2
                sum += doubled > 9 ? doubled - 9 : doubled
            } else {
                sum += digit
            }
        }
        return sum % 10 == 0
    }
}
