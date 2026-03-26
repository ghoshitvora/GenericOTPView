//
//  ContentView.swift
//  GenericOTPView
//
//  Created by Ghoshit on 26/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var otp4: String = ""
    @State private var otp4Alt: String = ""
    @State private var otp4Box: String = ""
    @State private var otp6Box: String = ""
    @State private var otp6Highlight: String = ""
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
                            style: .underline,
                            isHighlightEnabled: false
                        )
                    }

                    labeledExample(title: "2. Underline • 4-digit • Highlight") {
                        OTPField(
                            otp: $otp4Alt,
                            length: 4,
                            style: .underline,
                            isHighlightEnabled: true
                        )
                    }

                    labeledExample(title: "3. Box • 4-digit • No Highlight • No Background") {
                        OTPField(
                            otp: $otp4Box,
                            length: 4,
                            style: .box,
                            cornerRadius: 8,
                            boxBackgroundColor: .clear,
                            isHighlightEnabled: false
                        )
                    }

                    labeledExample(title: "4. Box • 6-digit • No Highlight • Background") {
                        OTPField(
                            otp: $otp6Box,
                            length: 6,
                            style: .box,
                            cornerRadius: 14,
                            boxBackgroundColor: Color.blue.opacity(0.08),
                            isHighlightEnabled: false
                        )
                    }

                    labeledExample(title: "5. Box • 6-digit • Highlight • Background") {
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
                    }

                    labeledExample(title: "6. Box • 6-digit • Secure • No Highlight • No Background") {
                        OTPField(
                            otp: $otp6Secure,
                            length: 6,
                            style: .box,
                            cornerRadius: 8,
                            boxBackgroundColor: .clear,
                            isHighlightEnabled: false,
                            isSecure: true
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

    @ViewBuilder
    private func section<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))

            VStack(spacing: 24) {
                content()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.9))
        )
    }

    @ViewBuilder
    private func labeledExample<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(.secondary)

            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 6)
    }
}

#Preview {
    ContentView()
}
