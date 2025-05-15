//
//  CompletionView.swift
//  Glint
//
//  Created by Atheer on 09/11/1446 AH.
//

import SwiftUI
import EffectsLibrary
struct CompletionView: View {
    var onHome: () -> Void
    var onTryAnother: () -> Void

    var body: some View {
        ZStack {
            // خلفية بيضاء كاملة
            Color.white
                .ignoresSafeArea()

            // تأثير الألعاب النارية في الخلفية
           //
            FireworksView()
                .ignoresSafeArea()

            // الكارد الأمامي
            VStack(spacing: 24) {
                // العنوان
                Text("Well Done! 🎉")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color("Button"))

                // الوصف
                Text("You showed up for yourself\nThat’s brave & beautiful")
                    .font(.system(size: 16))
                    .foregroundColor(Color("Button"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                // تشجيع إضافي
                Text("Keep going")
                    .font(.system(size: 14))
                    .foregroundColor(Color("Button"))

                // أزرار الإجراءات
                HStack(spacing: 16) {
                    Button(action: onTryAnother) {
                        Text("Try another")
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
            .background(Color("candypurple"))
            .cornerRadius(24)
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
    }
}
