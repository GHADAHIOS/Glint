

//Done by Hajar ⭐️

import Foundation

struct BreathingSession {
    enum BreathingPhase: String {
        case breatheIn = "Breathe In"
        case breatheOut = "Breathe Out"
    }

    var currentPhase: BreathingPhase = .breatheIn

    mutating func togglePhase() {
        currentPhase = (currentPhase == .breatheIn) ? .breatheOut : .breatheIn
    }
}
