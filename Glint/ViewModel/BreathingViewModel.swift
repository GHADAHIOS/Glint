

//Done by Hajar ⭐️


import Foundation
import SwiftUI

class BreathingViewModel: ObservableObject {
    @Published var session = BreathingSession()
    @Published var animateText = false
    @Published var breathText: String = "Breathe In"
    @Published var startAnimation = false

    private var timer: Timer?

    func start() {
        // Start the circle animation
        withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
            startAnimation = true
        }

        // Start the breathing cycle timer
        breathText = session.currentPhase.rawValue
        animateText = true

        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            // Step 1: Fade out text
            withAnimation(.easeInOut(duration: 0.4)) {
                self.animateText = false
            }

            // Step 2: Toggle breathing phase and fade back in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.session.togglePhase()
                self.breathText = self.session.currentPhase.rawValue

                withAnimation(.easeInOut(duration: 0.8)) {
                    self.animateText = true
                }
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
