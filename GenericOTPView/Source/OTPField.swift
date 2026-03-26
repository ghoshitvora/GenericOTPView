import SwiftUI

enum OTPFieldStyle {
    case underline
    case box
}

struct OTPField: View {
    @Binding private var otp: String

    private let length: Int
    private let style: OTPFieldStyle
    private let cornerRadius: CGFloat
    private let spacing: CGFloat
    private let lineWidth: CGFloat
    private let activeColor: Color
    private let inactiveColor: Color
    private let filledColor: Color
    private let boxBackgroundColor: Color
    private let isHighlightEnabled: Bool
    private let isHighlightBackgroundEnabled: Bool
    private let isSecure: Bool
    private let onComplete: ((String) -> Void)?

    @State private var isEditing: Bool = false
    @State private var lastCompletedOtp: String = ""
    @FocusState private var isFocused: Bool

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
    ) {
        assert(length == 4 || length == 6, "OTP length must be 4 or 6")
        self._otp = otp
        self.length = length == 6 ? 6 : 4
        self.style = style
        self.cornerRadius = cornerRadius
        self.spacing = spacing
        self.lineWidth = lineWidth
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.filledColor = filledColor
        self.boxBackgroundColor = boxBackgroundColor
        self.isHighlightEnabled = isHighlightEnabled
        self.isHighlightBackgroundEnabled = isHighlightBackgroundEnabled
        self.isSecure = isSecure
        self.onComplete = onComplete
    }

    var body: some View {
        ZStack {
            HStack(spacing: spacing) {
                ForEach(0..<length, id: \.self) { index in
                    digitView(for: index)
                }
            }
            .allowsHitTesting(false)

            TextField("", text: otpProxy, onEditingChanged: { isEditing = $0 })
                .focused($isFocused)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .foregroundColor(.clear)
                .accentColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(0.01)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isFocused = true
        }
    }

    private var otpProxy: Binding<String> {
        Binding(
            get: { otp },
            set: { newValue in
                let filtered = newValue.filter { $0.isNumber }
                let trimmed = String(filtered.prefix(length))
                otp = trimmed
                handleCompletionIfNeeded(for: trimmed)
            }
        )
    }

    private func handleCompletionIfNeeded(for value: String) {
        if value.count == length {
            if value != lastCompletedOtp {
                lastCompletedOtp = value
                onComplete?(value)
                isFocused = false
                dismissKeyboard()
            }
        } else {
            lastCompletedOtp = ""
        }
    }

    private func digitView(for index: Int) -> some View {
        let digit = digitAt(index)
        let isFilled = index < otp.count
        let isActive = isEditing && index == activeIndex

        switch style {
        case .underline:
            return AnyView(
                VStack(spacing: 8) {
                    Text(maskedDigit(digit))
                        .font(.title2.monospacedDigit())
                        .frame(height: 28)
                        .frame(maxWidth: .infinity)

                    Rectangle()
                        .frame(height: lineWidth)
                        .foregroundColor(underlineColor(isFilled: isFilled, isActive: isActive))
                }
            )
        case .box:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(boxFillColor(isFilled: isFilled, isActive: isActive))

                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(boxBorderColor(isFilled: isFilled, isActive: isActive), lineWidth: lineWidth)

                    Text(maskedDigit(digit))
                        .font(.title2.monospacedDigit())
                }
                .frame(height: 52)
                .frame(maxWidth: .infinity)
            )
        }
    }

    private var activeIndex: Int {
        min(max(otp.count, 0), length - 1)
    }

    private func digitAt(_ index: Int) -> String {
        guard index < otp.count else { return "" }
        let stringIndex = otp.index(otp.startIndex, offsetBy: index)
        return String(otp[stringIndex])
    }

    private func maskedDigit(_ digit: String) -> String {
        guard isSecure, !digit.isEmpty else { return digit }
        return "•"
    }

    private func underlineColor(isFilled: Bool, isActive: Bool) -> Color {
        if isActive { return activeColor }
        if isHighlightEnabled && isFilled { return activeColor }
        return inactiveColor
    }

    private func boxBorderColor(isFilled: Bool, isActive: Bool) -> Color {
        if isActive { return activeColor }
        if isHighlightEnabled && isFilled { return activeColor }
        return inactiveColor
    }

    private func boxFillColor(isFilled: Bool, isActive: Bool) -> Color {
        if isHighlightBackgroundEnabled && isHighlightEnabled && isFilled {
            return filledColor
        }
        return boxBackgroundColor
    }

    private func dismissKeyboard() {
        #if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
}
