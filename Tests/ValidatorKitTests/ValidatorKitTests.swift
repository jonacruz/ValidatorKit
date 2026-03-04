import Testing
@testable import ValidatorKit

@Suite("ValidatorKit Tests")
struct ValidatorKitTests {
    
    // MARK: - Email
    @Test("Valid email passes")
    func emailValid() {
        let result = Validator<String>()
            .add(EmailRule())
            .validate("test@example.com")
        #expect(result.isValid)
    }
    
    @Test("Invalid email fails")
    func emailInvalid() {
        let result = Validator<String>()
            .add(EmailRule())
            .validate("not-an-email")
        #expect(!result.isValid)
        #expect(result.firstError == "Not a valid email")
    }
    
    // MARK: - String Rules
    @Test("Empty string fails NonEmptyRule")
    func nonEmpty() {
        let result = Validator<String>()
            .add(NonEmptyRule())
            .validate("   ")
        #expect(!result.isValid)
    }
    
    @Test("Multiple rules collect all errors")
    func multipleRules() {
        let result = Validator<String>()
            .add(NonEmptyRule())
            .add(MinLengthRule(8))
            .validate("hi")
        #expect(!result.isValid)
        #expect(result.errors.count == 1)
    }
    
    @Test("MinLength passes when meets requirement")
    func minLengthValid() {
        let result = Validator<String>()
            .add(MinLengthRule(4))
            .validate("hello")
        #expect(result.isValid)
    }
    
    @Test("MaxLength fails when exceeded")
    func maxLengthInvalid() {
        let result = Validator<String>()
            .add(MaxLengthRule(5))
            .validate("toolongstring")
        #expect(!result.isValid)
    }
    
    // MARK: - Numeric Rules
    @Test("RangeRule fails below minimum")
    func rangeBelowMin() {
        let result = Validator<Int>()
            .add(RangeRule(18, 99))
            .validate(15)
        #expect(!result.isValid)
    }
    
    @Test("RangeRule passes within range")
    func rangeValid() {
        let result = Validator<Int>()
            .add(RangeRule(18, 99))
            .validate(25)
        #expect(result.isValid)
    }
    
    // MARK: - Common Rules
    @Test("MatchRule fails when values differ")
    func matchInvalid() {
        let result = Validator<String>()
            .add(MatchRule("password123"))
            .validate("different")
        #expect(!result.isValid)
        #expect(result.firstError == "Does not match")
    }
    
    @Test("Valid URL passes")
    func urlValid() {
        let result = Validator<String>()
            .add(URLRule())
            .validate("https://example.com")
        #expect(result.isValid)
    }
    
    @Test("Invalid phone fails")
    func phoneInvalid() {
        let result = Validator<String>()
            .add(PhoneRule())
            .validate("123")
        #expect(!result.isValid)
    }

    // MARK: - AllowedCharactersRule

    @Test("AllowedCharactersRule passes with alphanumeric input")
    func allowedCharactersValid() {
        let result = Validator<String>()
            .add(AllowedCharactersRule(.alphanumerics))
            .validate("abc123")
        #expect(result.isValid)
    }

    @Test("AllowedCharactersRule fails with special characters")
    func allowedCharactersInvalid() {
        let result = Validator<String>()
            .add(AllowedCharactersRule(.alphanumerics))
            .validate("abc!@#")
        #expect(!result.isValid)
        #expect(result.firstError == "Contains invalid characters")
    }

    // MARK: - CreditCardRule

    @Test("Valid Visa number passes CreditCardRule")
    func creditCardValid() {
        let result = Validator<String>()
            .add(CreditCardRule())
            .validate("4111111111111111")
        #expect(result.isValid)
    }

    @Test("Invalid credit card number fails CreditCardRule")
    func creditCardInvalid() {
        let result = Validator<String>()
            .add(CreditCardRule())
            .validate("1234567890123456")
        #expect(!result.isValid)
        #expect(result.firstError == "Invalid credit card number")
    }

    @Test("Credit card preset validates correctly")
    func creditCardPreset() {
        #expect(Validator<String>.creditCard.validate("4111111111111111").isValid)
        #expect(!Validator<String>.creditCard.validate("").isValid)
        #expect(!Validator<String>.creditCard.validate("1234567890123456").isValid)
    }

    // MARK: - ComparatorRules

    @Test("GreaterThanRule passes when value is greater")
    func greaterThanValid() {
        let result = Validator<Int>()
            .add(GreaterThanRule(than: 10))
            .validate(15)
        #expect(result.isValid)
    }

    @Test("GreaterThanRule fails when value is equal or less")
    func greaterThanInvalid() {
        let result = Validator<Int>()
            .add(GreaterThanRule(than: 10))
            .validate(10)
        #expect(!result.isValid)
    }

    @Test("LessThanRule passes when value is less")
    func lessThanValid() {
        let result = Validator<Int>()
            .add(LessThanRule(than: 100))
            .validate(50)
        #expect(result.isValid)
    }

    @Test("LessThanRule fails when value is equal or greater")
    func lessThanInvalid() {
        let result = Validator<Int>()
            .add(LessThanRule(than: 100))
            .validate(100)
        #expect(!result.isValid)
    }

    @Test("GreaterThanRule supports dynamic field closure")
    func greaterThanDynamicField() {
        var threshold = 5
        let validator = Validator<Int>().add(GreaterThanRule(than: { threshold }))
        #expect(validator.validate(10).isValid)
        threshold = 20
        #expect(!validator.validate(10).isValid)
    }

    // MARK: - ConditionalRule

    @Test("ConditionalRule skips validation when condition is false")
    func conditionalSkipped() {
        let result = Validator<String>()
            .add(ConditionalRule(when: { !$0.isEmpty }, apply: EmailRule()))
            .validate("")
        #expect(result.isValid)
    }

    @Test("ConditionalRule applies validation when condition is true")
    func conditionalApplied() {
        let result = Validator<String>()
            .add(ConditionalRule(when: { !$0.isEmpty }, apply: EmailRule()))
            .validate("not-an-email")
        #expect(!result.isValid)
        #expect(result.firstError == "Not a valid email")
    }

    @Test("ConditionalRule passes when condition is true and rule is satisfied")
    func conditionalAppliedAndValid() {
        let result = Validator<String>()
            .add(ConditionalRule(when: { !$0.isEmpty }, apply: EmailRule()))
            .validate("user@example.com")
        #expect(result.isValid)
    }
}
