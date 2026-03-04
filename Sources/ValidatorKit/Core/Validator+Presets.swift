//
//  File.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import Foundation

public extension Validator where Value == String {
    static var email: Validator<String> {
        Validator()
            .add(NonEmptyRule())
            .add(EmailRule())
    }
    
    static var password: Validator<String> {
        Validator()
            .add(NonEmptyRule())
            .add(MinLengthRule(8))
    }
    
    static var username: Validator<String> {
        Validator()
            .add(NonEmptyRule())
            .add(MinLengthRule(3))
            .add(MaxLengthRule(20))
    }
        
    static var phone: Validator<String> {
        Validator()
            .add(NonEmptyRule())
            .add(PhoneRule())
    }
        
    static var url: Validator<String> {
        Validator()
            .add(NonEmptyRule())
            .add(URLRule())
    }

    static var creditCard: Validator<String> {
        Validator()
            .add(NonEmptyRule())
            .add(CreditCardRule())
    }
}
