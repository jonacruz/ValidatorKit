# ValidatorKit

A lightweight and composable validation library for Swift.

## Installation

### Swift Package Manager
```swift
.package(url: "https://github.com/jonacruz/ValidatorKit", from: "1.0.0")
```

## Usage

### Basic Validation
```swift
let result = Validator<String>()
    .add(NonEmptyRule())
    .add(MinLengthRule(8))
    .validate("hello")

if !result.isValid {
    print(result.errors) // ["Minimum 8 characters"]
}
```

### Presets
```swift
let result = Validator.email.validate("test@example.com")
let result = Validator.password.validate("mypassword")
let result = Validator.phone.validate("+1234567890")
```

### SwiftUI
```swift
ValidatedField("Email", text: $email, validator: .email)
ValidatedField("Password", text: $password, validator: .password)
```

### Custom Rules
```swift
struct UppercaseRule: ValidationRule {
    typealias Value = String
    var errorMessage = "Must contain an uppercase letter"
    
    func validate(_ value: String) -> Bool {
        value.contains(where: \.isUppercase)
    }
}

let result = Validator<String>()
    .add(UppercaseRule())
    .validate("hello") // invalid
```

## Available Rules

### String
| Rule | Description |
|------|-------------|
| `NonEmptyRule` | Field cannot be empty |
| `MinLengthRule(n)` | Minimum n characters |
| `MaxLengthRule(n)` | Maximum n characters |
| `EmailRule` | Valid email format |
| `RegexRule(pattern)` | Matches regex pattern |

### Numeric
| Rule | Description |
|------|-------------|
| `MinValueRule(n)` | Value >= n |
| `MaxValueRule(n)` | Value <= n |
| `RangeRule(min, max)` | Value between min and max |

### Common
| Rule | Description |
|------|-------------|
| `MatchRule(value)` | Must match given value |
| `URLRule` | Valid http/https URL |
| `PhoneRule` | Valid phone number |

## License

MIT
