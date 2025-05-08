//
//  TimeUpView.swift
//  Glint
//
//  Created by Atheer on 09/11/1446 AH.
//
import SwiftUI

struct TimeUpView: View {
    var onRetry: () -> Void
    var onHome: () -> Void

    var body: some View {
        ZStack {
            // خلفية نصف شفافة
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            // الكارد الرئيسي
            VStack(spacing: 24) {
                Text("Time’s up 🙁")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color("TextH2"))

                Text("Deep breaths, you can try again\nwhenever you’re ready")
                    .font(.system(size: 16))
                    .foregroundColor(Color("TextH2"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                HStack(spacing: 16) {
                    Button(action: onRetry) {
                        Text("Try again")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color("Button"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }

                    Button(action: onHome) {
                        Text("Home")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color("Button"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
            }
            .padding(32)
            .background(Color("lightpurple"))
            .cornerRadius(24)
            .padding(.horizontal, 24)
        }
    }
}
