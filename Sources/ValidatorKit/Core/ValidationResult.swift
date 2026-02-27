//
//  ValidationResult.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import Foundation

public enum ValidationResult {
    case valid
    case invalid([String])
    
    public var isValid: Bool {
        if case .valid = self { return true }
        return false
    }
    
    public var errors: [String] {
        if case .invalid(let messages) = self { return messages }
        return []
    }
    
    public var firstError: String? {
        return errors.first
    }
}
