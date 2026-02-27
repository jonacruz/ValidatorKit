//
//  Validator.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import Foundation

public class Validator<Value> {
    public var rules: [(_ value: Value) -> ValidationResult] = []
    
    public init() {}
    
    @discardableResult
    public func add<Rule: ValidationRule>(_ rule: Rule) -> Self where Rule.Value == Value {
        rules.append { value in
            rule.validate(value) ? .valid : .invalid([rule.errorMessage])
        }
        return self
    }
    
    public func validate(_ value: Value) -> ValidationResult {
        let errors = rules
            .map{ $0(value) }
            .flatMap{ $0.errors }
        
        return errors.isEmpty ? .valid : .invalid(errors)
    }
}
