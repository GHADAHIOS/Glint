//
//  TimeUpView.swift
//  Glint
//
//  Created by Atheer on 09/11/1446 AH.
//

import SwiftUI

struct TimeUpView: View {
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Time’s up 😞")
                .font(.title)

            Text("Deep breaths, You can try again whenever you're ready")
                .multilineTextAlignment(.center)

            Button("Try again", action: onRetry)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)

            Button("Home", action: {})
                .padding()
        }
        .padding()
    }
}
