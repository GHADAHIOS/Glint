import SwiftUI




struct ProgressBarView: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                HStack(spacing: 0) {
                    ForEach(0..<totalSteps - 1, id: \.self) { index in
                        Rectangle()
                            .fill(index < currentStep  ? Color("lightpurple") : Color.gray.opacity(0.3))
                            .animation(.easeInOut(duration: 0.2), value: currentStep)
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
                        .animation(.easeInOut(duration: 0.3), value: currentStep)
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






