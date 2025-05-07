//
//  SplashScreen.swift
//  Dreamaze
//
//  Created by GHADAH ALENEZI on 05/11/1446 AH.
//

import SwiftUI

struct SplashView: View {
    @State private var logoOpacity = 0.0

    var body: some View {
        ZStack {
            Color.grayCards
                .ignoresSafeArea()

            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                
                    .scaledToFit()
                    .frame(width: 237, height: 237)
                    .opacity(logoOpacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            logoOpacity = 1.0
                        }
                    }
                Spacer()
            }
        }
    }
}

#Preview {
    SplashView()
}



