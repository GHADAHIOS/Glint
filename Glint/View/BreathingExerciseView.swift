//
//  BreathingExerciseView.swift
//  Glint
//
//  Created by Renad Alotaibi on 07/11/1446 AH.
//



import SwiftUI

struct BreathingExerciseView: View {

    @State var startAnimation = true

    var body: some View {
        
        ZStack {
            ForEach((0...2), id: \.self) {circleSetNumber in
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.purple, .white]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 150, height: 150)
                        .offset(y: startAnimation ? 75 : 0)

                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.purple, .white]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 150, height: 150)
                        .offset(y: startAnimation ? -75 : 0)
                }
                .opacity(0.5)
                .rotationEffect(.degrees(startAnimation ? Double(circleSetNumber*60) : 0))
                .scaleEffect(startAnimation ? 1 : 0.2)
                .onAppear {
                    withAnimation(.easeInOut.repeatForever(autoreverses: true).speed(0.1)) {
                         startAnimation.toggle()
                    }
                 }
            }
        }
    }
}
#Preview {
    BreathingExerciseView()
}


