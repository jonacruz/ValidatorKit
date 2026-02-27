//
//  ValidationRule.swift
//  ValidatorKit
//
//  Created by Jonathan Abimael on 27/02/26.
//

import Foundation

public protocol ValidationRule {
    associatedtype Value
    var errorMessage: String { get }
    func validate(_ value: Value) -> Bool
}
