//
//  CompletionView.swift
//  Glint
//
//  Created by Atheer on 09/11/1446 AH.
//

import SwiftUI

struct CompletionView: View {
    var onHome: () -> Void
    var onTryAnother: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Well Done! 🎉")
                .font(.title)

            Text("You showed up for yourself\nThat's brave & beautiful")
                .multilineTextAlignment(.center)

            Button("Try another", action: onTryAnother)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)

            Button("Home", action: onHome)
                .padding()
        }
        .padding()
    }
}

