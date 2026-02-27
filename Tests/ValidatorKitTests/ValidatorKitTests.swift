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
}
