//
//  GroundingViewModel.swift
//  Glint
//
//  Created by Atheer on 09/11/1446 AH.
//
import Foundation
import SwiftUI

struct Step {
    let intro: String
    let focusWord: String
    let ending: String
    let placeholder: String
    let count: Int
}

class GroundingViewModel: ObservableObject {
    static let defaultSteps: [Step] = [
        Step(intro: "Look around and name 5 things you can ",
             focusWord: "see",
             ending: " right now?",
             placeholder: "i.e. Couch",
             count: 5),
        Step(intro: "Focus and name 4 things you can ",
             focusWord: "touch",
             ending: "?",
             placeholder: "i.e. Table",
             count: 4),
        Step(intro: "Listen carefully and name 3 things you can ",
             focusWord: "hear",
             ending: "?",
             placeholder: "i.e. People talking",
             count: 3),
        Step(intro: "Take a deep breath and name 2 things you can ",
             focusWord: "smell",
             ending: "?",
             placeholder: "i.e. Coffee",
             count: 2),
        Step(intro: "Pay attention and name 1 thing you can ",
             focusWord: "taste",
             ending: "?",
             placeholder: "i.e. Gum",
             count: 1)
    ]

    @Published var currentStepIndex = 0
    @Published var timeRemaining = 120
    @Published var isTimeUp = false
    @Published var isCompleted = false

    @Published var answers: [[String]]
    let steps: [Step]

    var timer: Timer?

    init() {
        self.steps = GroundingViewModel.defaultSteps
        self.answers = steps.map { Array(repeating: "", count: $0.count) }
    }

    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }

    func startTimer() {
        timeRemaining = 120
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timeRemaining -= 1
            if self.timeRemaining <= 0 {
                self.timer?.invalidate()
                self.isTimeUp = true
            }
        }
    }

    func submitStep() {
        if currentStepIndex < steps.count - 1 {
            currentStepIndex += 1
        } else {
            timer?.invalidate()
            isCompleted = true
        }
    }

    func reset() {
        currentStepIndex = 0
        isTimeUp = false
        isCompleted = false
        timeRemaining = 120
        self.answers = steps.map { Array(repeating: "", count: $0.count) }
        startTimer()
    }
}


