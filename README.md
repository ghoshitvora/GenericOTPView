# GenericOTPView

A SwiftUI OTP input component with underline and box styles, optional highlighting, secure entry, and completion callbacks.

**Features**
- 4 or 6 digit OTP input
- Underline or box style
- Optional highlight and filled background for completed digits
- Secure masking for OTP digits
- Completion callback when the OTP is fully entered

**Requirements**
- iOS 15+
- Xcode 14+
- SwiftUI

**Quick Start**
Add `OTPField` to your SwiftUI view and bind it to a `@State` string.

```swift
import SwiftUI

struct ContentView: View {
    @State private var otp: String = ""

    var body: some View {
        OTPField(
            otp: $otp,
            length: 6,
            style: .box,
            cornerRadius: 12,
            filledColor: Color.blue.opacity(0.18),
            boxBackgroundColor: Color.blue.opacity(0.06),
            isHighlightEnabled: true,
            isHighlightBackgroundEnabled: true,
            isSecure: false,
            onComplete: { code in
                print("OTP complete: \(code)")
            }
        )
        .padding()
    }
}
```

**Examples**
These examples mirror the demo in `GenericOTPView/GenericOTPView/ContentView.swift`.

```swift
// 1. Underline • 4-digit
OTPField(otp: $otp4, length: 4, style: .underline, isHighlightEnabled: false)

// 2. Underline • 4-digit • Highlight
OTPField(otp: $otp4Alt, length: 4, style: .underline, isHighlightEnabled: true)

// 3. Box • 4-digit • No Highlight • No Background
OTPField(
    otp: $otp4Box,
    length: 4,
    style: .box,
    cornerRadius: 8,
    boxBackgroundColor: .clear,
    isHighlightEnabled: false
)

// 4. Box • 6-digit • No Highlight • Background
OTPField(
    otp: $otp6Box,
    length: 6,
    style: .box,
    cornerRadius: 14,
    boxBackgroundColor: Color.blue.opacity(0.08),
    isHighlightEnabled: false
)

// 5. Box • 6-digit • Highlight • Background
OTPField(
    otp: $otp6Highlight,
    length: 6,
    style: .box,
    cornerRadius: 14,
    filledColor: Color.blue.opacity(0.18),
    boxBackgroundColor: Color.blue.opacity(0.06),
    isHighlightEnabled: true,
    isHighlightBackgroundEnabled: true
)

// 6. Box • 6-digit • Secure • No Highlight • No Background
OTPField(
    otp: $otp6Secure,
    length: 6,
    style: .box,
    cornerRadius: 8,
    boxBackgroundColor: .clear,
    isHighlightEnabled: false,
    isSecure: true
)
```

**API**

```swift
init(
    otp: Binding<String>,
    length: Int,
    style: OTPFieldStyle = .underline,
    cornerRadius: CGFloat = 8,
    spacing: CGFloat = 12,
    lineWidth: CGFloat = 2,
    activeColor: Color = .blue,
    inactiveColor: Color = .gray.opacity(0.4),
    filledColor: Color = .blue.opacity(0.15),
    boxBackgroundColor: Color = .clear,
    isHighlightEnabled: Bool = true,
    isHighlightBackgroundEnabled: Bool = false,
    isSecure: Bool = false,
    onComplete: ((String) -> Void)? = nil
)
```

**Parameter Notes**
- `length` supports only 4 or 6 digits. Other values will be clamped to 4.
- `isHighlightEnabled` affects underline and box border colors for filled digits.
- `isHighlightBackgroundEnabled` fills the box background for filled digits.
- `isSecure` masks each digit with a bullet.
- `onComplete` fires once per unique completed code.

**Behavior**
- Numeric-only input is enforced.
- The keyboard is dismissed when the OTP is complete.

**Project Files**
- OTP view: `GenericOTPView/GenericOTPView/Source/OTPField.swift`
- Demo usage: `GenericOTPView/GenericOTPView/ContentView.swift`
