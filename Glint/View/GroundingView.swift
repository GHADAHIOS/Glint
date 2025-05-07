
import SwiftUI

struct GroundingView: View {
    @ObservedObject var viewModel: GroundingViewModel
    var body: some View {
        if viewModel.isTimeUp {
            TimeUpView(onRetry: viewModel.reset)
        } else if viewModel.isCompleted {
            CompletionView(onHome: {}, onTryAnother: viewModel.reset)
        } else {
            let step = viewModel.steps[viewModel.currentStepIndex]
            let currentAnswers = viewModel.answers[viewModel.currentStepIndex]
            let isStepFilled = !currentAnswers.contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty })

            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button("Cancel") {
                        }
                        .foregroundColor(.gray)

                        Spacer()

                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                            Text(viewModel.formattedTime)
                                .font(.system(size: 16))
                                .foregroundColor(Color("Button"))
                        }
                    }
                    .padding(.horizontal)

                    // هنا البروقرس بار نوره حطي التعديل هنا
                    HStack(spacing: 12) {
                        ForEach(0..<5, id: \.self) { index in
                            if index < viewModel.currentStepIndex {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("TextH2"))
                                    .font(.system(size: 20))
                            } else if index == viewModel.currentStepIndex {
                                Circle()
                                    .fill(Color("TextH2"))
                                    .frame(width: 12, height: 12)
                            } else {
                                Circle()
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                                    .frame(width: 12, height: 12)
                            }
                        }
                    }
                    .padding(.horizontal)

                    (
                        Text(step.intro)
                        + Text(step.focusWord).bold()
                        + Text(step.ending)
                    )
                    .font(.system(size: 24))
                    .foregroundColor(Color("TextH2"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top)

                    ForEach(0..<step.count, id: \.self) { i in
                        TextField(i == 0 ? step.placeholder : "", text: $viewModel.answers[viewModel.currentStepIndex][i])
                            .padding()
                            .background(Color("Textfield"))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        viewModel.submitStep()
                    }) {
                        Text("Next step")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 180, height: 20)
                            .padding()
                            .background(isStepFilled ? Color("Button"): Color.gray.opacity(0.3))
                            .foregroundColor(Color("Textlight"))
                            .cornerRadius(12)
                    }
                    .disabled(!isStepFilled)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 10)

                    Spacer()
                }
            }
            
            .ignoresSafeArea(.keyboard)
            .padding(.top)
            .onAppear {
                viewModel.startTimer()
            }
        }
    }
}

#Preview {
    GroundingView(viewModel: GroundingViewModel())
}


