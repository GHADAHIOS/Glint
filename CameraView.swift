import SwiftUI

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var randomColorWord = ""
    @State private var timeRemaining = 180
    @State private var matchProgress = 0
    @State private var currentDetectedColor = "..."
    @State private var capturedColor: UIColor? = nil
    @State private var showWrongPopup = false
    @State private var showTimesUpPopup = false
    @State private var showCompletionView = false 

    private let colorWords = [
        "red", "green", "blue", "yellow", "orange", "purple", "brown",
        "pink", "white", "black", "gray"
    ]

    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }

    var body: some View {
        ZStack {
            CameraFeedView { color in
                capturedColor = color
            }

            CrosshairView()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)

            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 18))
                        Text(formattedTime)
                            .font(.system(size: 18))
                    }
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)

                Text("Find 3 items with \(randomColorWord) color")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(.textH2).opacity(0.5))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding(.top, 50)

                Spacer()

                ProgressBarView2(totalSteps: 3, currentStep: matchProgress)
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                Spacer().frame(height: 70)

                Button(action: {
                    if let color = capturedColor {
                        let name = closestBaseColorName(to: color)
                        currentDetectedColor = name

                        if name == randomColorWord {
                            matchProgress += 1
                            if matchProgress == 3 {
                                showCompletionView = true
                            }
                        } else {
                            showWrongPopup = true
                        }
                    }
                }) {
                    ZStack {
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 4)
                            .frame(width: 72, height: 72)

                        Circle()
                            .fill(Color.white)
                            .frame(width: 55, height: 55)
                    }
                }
                .padding(.bottom, 50)
            }

            if showWrongPopup {
                WrongAnswerPopup {
                    showWrongPopup = false
                }
                .transition(.scale)
            }

            if showTimesUpPopup {
                TimesUpPopup(
                    tryAgainAction: {
                        timeRemaining = 180
                        matchProgress = 0
                        showTimesUpPopup = false
                        randomColorWord = colorWords.randomElement() ?? "red"
                    },
                    goHomeAction: {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
                .transition(.scale)
            }

            if showCompletionView {
                CompletionView(
                    onHome: {
                        presentationMode.wrappedValue.dismiss()
                    },
                    onTryAnother: {
                        matchProgress = 0
                        timeRemaining = 180
                        randomColorWord = colorWords.randomElement() ?? "red"
                        showCompletionView = false
                    }
                )
                .transition(.scale)
            }
        }
        .onAppear {
            randomColorWord = colorWords.randomElement() ?? "red"
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else if !showTimesUpPopup && matchProgress < 3 {
                showTimesUpPopup = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}



struct CrosshairView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 2, height: 20)
            Rectangle()
                .frame(width: 20, height: 2)
        }
    }
}

struct ProgressBarView2: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                HStack(spacing: 0) {
                    ForEach(0..<totalSteps - 1, id: \.self) { index in
                        Rectangle()
                            .fill(index < currentStep ? Color("lightpurple") : Color.gray.opacity(0.3))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 24)

                HStack {
                    ForEach(0..<totalSteps, id: \.self) { idx in
                        ZStack {
                            Circle()
                                .fill(Color("BGbase"))
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Circle()
                                        .strokeBorder(
                                            idx < currentStep ? Color("lightpurple") : Color.gray.opacity(0.3),
                                            lineWidth: 2
                                        )
                                )

                            if idx < currentStep {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color("lightpurple"))
                            } else if idx == currentStep {
                                Circle()
                                    .fill(Color("lightpurple"))
                                    .frame(width: 8, height: 8)
                            }
                        }

                        if idx < totalSteps - 1 {
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .frame(height: 32)
        }
    }
}

extension Color {
    init(named name: String) {
        switch name {
        case "red": self = .red
        case "green": self = .green
        case "blue": self = .blue
        case "yellow": self = .yellow
        case "orange": self = .orange
        case "purple": self = .purple
        case "brown": self = .brown
        case "pink": self = .pink
        case "white": self = .white
        case "black": self = .black
        case "gray": self = .gray
        default: self = .clear
        }
    }
}

#Preview {
    CameraView()
}
