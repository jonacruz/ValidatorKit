//
//  StringRules.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import Foundation

public struct NonEmptyRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    
    public init(errorMessage: String = "Field cannot be empty") {
        self.errorMessage = errorMessage
    }
    
    public func validate(_ value: String) -> Bool {
        !value.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

public struct MinLengthRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    let minLength: Int
    
    public init(_ minLenght: Int, message: String? = nil) {
        self.minLength = minLenght
        self.errorMessage = message ?? "Field must be at least \(minLength) characters"
    }
    
    public func validate(_ value: String) -> Bool {
        value.count >= minLength
    }
}

public struct MaxLengthRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    let maxLength: Int
    
    public init(_ maxLenght: Int, message: String? = nil) {
        self.maxLength = maxLenght
        self.errorMessage = message ?? "Field must be at most \(maxLength) characters"
    }
    
    public func validate(_ value: String) -> Bool {
        value.count <= maxLength
    }
}

public struct EmailRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    
    public init(errorMessage: String = "Not a valid email") {
        self.errorMessage = errorMessage
    }
    
    public func validate(_ value: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return value.range(of: regex, options: .regularExpression) != nil
    }
}

public struct RegexRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    let pattern: String

    public init(_ pattern: String, message: String = "Invalid Format") {
        self.pattern = pattern
        self.errorMessage = message
    }

    public func validate(_ value: String) -> Bool {
        value.range(of: pattern, options: .regularExpression) != nil
    }
}

public struct AllowedCharactersRule: ValidationRule {
    public typealias Value = String
    public var errorMessage: String
    private let characterSet: CharacterSet

    public init(_ characterSet: CharacterSet, message: String = "Contains invalid characters") {
        self.characterSet = characterSet
        self.errorMessage = message
    }

    public func validate(_ value: String) -> Bool {
        value.unicodeScalars.allSatisfy { characterSet.contains($0) }
    }
}
