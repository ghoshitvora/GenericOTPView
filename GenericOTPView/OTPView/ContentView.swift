//
//  ContentView.swift
//  GenericOTPView
//
//  Created by Ghoshit on 26/03/26.
//

import SwiftUI

struct ContentView: View {
    // Holds the 4-digit OTP for the basic underline style.
    @State private var otp4: String = ""
    // Holds the 4-digit OTP for the underline style with highlight enabled.
    @State private var otp4Alt: String = ""
    // Holds the 4-digit OTP for the box style without background or highlight.
    @State private var otp4Box: String = ""
    // Holds the 6-digit OTP for the box style with a subtle background.
    @State private var otp6Box: String = ""
    // Holds the 6-digit OTP for the box style with highlight and filled background.
    @State private var otp6Highlight: String = ""
    // Holds the 6-digit OTP for the secure (masked) box style.
    @State private var otp6Secure: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                Text("OTPField Examples")
                    .font(.system(size: 26, weight: .bold, design: .rounded))

                section(title: "Examples") {
                    labeledExample(title: "1. Underline • 4-digit") {
                        OTPField(
                            otp: $otp4,
                            length: 4,
                            style: .underline, // Draws an underline for each digit.
                            isHighlightEnabled: false // Disables active-color highlight for filled digits.
                        )
                    }

                    labeledExample(title: "2. Underline • 4-digit • Highlight") {
                        OTPField(
                            otp: $otp4Alt,
                            length: 4,
                            style: .underline, // Underline style.
                            isHighlightEnabled: true // Highlights filled digits with activeColor.
                        )
                    }

                    labeledExample(title: "3. Box • 4-digit • No Highlight • No Background") {
                        OTPField(
                            otp: $otp4Box,
                            length: 4,
                            style: .box,
                            cornerRadius: 8, // Rounds the box corners.
                            boxBackgroundColor: .clear, // Removes box fill.
                            isHighlightEnabled: false // Keeps border in inactiveColor.
                        )
                    }

                    labeledExample(title: "4. Box • 6-digit • No Highlight • Background") {
                        OTPField(
                            otp: $otp6Box,
                            length: 6,
                            style: .box,
                            cornerRadius: 14,
                            boxBackgroundColor: Color.blue.opacity(0.08), // Subtle box fill.
                            isHighlightEnabled: false
                        )
                    }

                    labeledExample(title: "5. Box • 6-digit • Highlight • Background") {
                        OTPField(
                            otp: $otp6Highlight,
                            length: 6,
                            style: .box,
                            cornerRadius: 14,
                            filledColor: Color.blue.opacity(0.18), // Fill for completed digits.
                            boxBackgroundColor: Color.blue.opacity(0.06), // Base box fill.
                            isHighlightEnabled: true, // Active-color border for filled digits.
                            isHighlightBackgroundEnabled: true // Uses filledColor for completed digits.
                        )
                    }

                    labeledExample(title: "6. Box • 6-digit • Secure • No Highlight • No Background") {
                        OTPField(
                            otp: $otp6Secure,
                            length: 6,
                            style: .box,
                            cornerRadius: 8,
                            boxBackgroundColor: .clear,
                            isHighlightEnabled: false,
                            isSecure: true // Masks each digit with a bullet.
                        )
                    }
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [Color.white, Color.blue.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

}

#Preview {
    ContentView()
}
