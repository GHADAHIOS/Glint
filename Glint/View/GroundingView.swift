/*
import SwiftUI

struct GroundingView: View {
    @ObservedObject var viewModel: GroundingViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        if viewModel.isTimeUp {
                TimeUpView(
                    onRetry: viewModel.reset,
                    onHome: { dismiss() }
                )
            } else if viewModel.isCompleted {
                CompletionView(
                    onHome: { dismiss() },
                    onTryAnother: viewModel.reset
                )
            } else {
            let step = viewModel.steps[viewModel.currentStepIndex]
            let currentAnswers = viewModel.answers[viewModel.currentStepIndex]
            let isStepFilled = !currentAnswers.contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty })

            ScrollView{
                
                VStack(alignment: .leading, spacing: 20) {
                   
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .foregroundColor(Color("lightpurple"))
                            Text(viewModel.formattedTime)
                                .font(.system(size: 16))
                                .foregroundColor (Color("lightpurple"))
                        }
                    .padding(.horizontal)

                    ProgressBarView(totalSteps: viewModel.steps.count, currentStep: viewModel.currentStepIndex)
                        .padding(.horizontal)


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
                        TextField(i == 0 ? step.placeholder : "", text: viewModel.bindingForAnswer(stepIndex: viewModel.currentStepIndex, itemIndex: i)) .padding()
                            .background(Color("Textfield"))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        viewModel.submitStep()
                    }) {
                        Text("Next step")
                            .font(.system(size: 20, weight: .medium, design:.rounded))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(isStepFilled ? Color("Button"): Color.gray.opacity(0.3))
                            .foregroundColor(Color("Textlight"))
                            .clipShape(Capsule())
                            .shadow(color: Color.white.opacity(isStepFilled ? 0.2 : 0), radius: 10, x: 0, y: 5)
                            
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


*/
/*
import SwiftUI

struct GroundingView: View {
    @ObservedObject var viewModel: GroundingViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if viewModel.isTimeUp {
            TimeUpView(
                onRetry: viewModel.reset,
                onHome: { dismiss() }
            )
        } else if viewModel.isCompleted {
            CompletionView(
                onHome: { dismiss() },
                onTryAnother: viewModel.reset
            )
        } else {
            let step = viewModel.steps[viewModel.currentStepIndex]
            let currentAnswers = viewModel.answers[viewModel.currentStepIndex]
            let isStepFilled = !currentAnswers.contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty })

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(Color("lightpurple"))
                        Text(viewModel.formattedTime)
                            .font(.system(size: 16))
                            .foregroundColor(Color("lightpurple"))
                    }
                    .padding(.horizontal)

                    ProgressBarView(totalSteps: viewModel.steps.count, currentStep: viewModel.currentStepIndex)
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
                        TextField(i == 0 ? step.placeholder : "", text: viewModel.bindingForAnswer(stepIndex: viewModel.currentStepIndex, itemIndex: i))
                            .padding()
                            .background(Color("Textfield"))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        viewModel.submitStep()
                    }) {
                        Text("Next step")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(isStepFilled ? Color("Button") : Color.gray.opacity(0.3))
                            .foregroundColor(Color("Textlight"))
                            .clipShape(Capsule())
                            .shadow(color: Color.white.opacity(isStepFilled ? 0.2 : 0), radius: 10, x: 0, y: 5)
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
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(Color("lightpurple"))
            )
            .onAppear {
                viewModel.startTimer()
            }
        }
    }
}

#Preview {
    GroundingView(viewModel: GroundingViewModel())
}
*/
/*
import SwiftUI

struct GroundingView: View {
    @ObservedObject var viewModel: GroundingViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if viewModel.isTimeUp {
            TimeUpView(
                onRetry: viewModel.reset,
                onHome: { dismiss() }
            )
        } else if viewModel.isCompleted {
            CompletionView(
                onHome: { dismiss() },
                onTryAnother: viewModel.reset
            )
        } else {
            let step = viewModel.steps[viewModel.currentStepIndex]
            let currentAnswers = viewModel.answers[viewModel.currentStepIndex]
            let isStepFilled = !currentAnswers.contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty })

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .foregroundColor(Color("lightpurple"))
                            Text(viewModel.formattedTime)
                                .font(.system(size: 16))
                                .foregroundColor(Color("lightpurple"))
                        }
                        .padding(.horizontal)

                        ProgressBarView(totalSteps: viewModel.steps.count, currentStep: viewModel.currentStepIndex)
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
                            TextField(i == 0 ? step.placeholder : "", text: viewModel.bindingForAnswer(stepIndex: viewModel.currentStepIndex, itemIndex: i))
                                .padding()
                                .background(Color("Textfield"))
                                .cornerRadius(8)
                                .padding(.horizontal)
                                .id(i) // 🟣 مهم للـ scrollTo
                                .onTapGesture {
                                    withAnimation {
                                        proxy.scrollTo(i, anchor: .center)
                                    }
                                }
                        }

                        Button(action: {
                            viewModel.submitStep()
                        }) {
                            Text("Next step")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .background(isStepFilled ? Color("Button") : Color.gray.opacity(0.3))
                                .foregroundColor(Color("Textlight"))
                                .clipShape(Capsule())
                                .shadow(color: Color.white.opacity(isStepFilled ? 0.2 : 0), radius: 10, x: 0, y: 5)
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
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color("lightpurple"))
                )
                .onAppear {
                    viewModel.startTimer()
                }
            }
        }
    }
}

#Preview {
    GroundingView(viewModel: GroundingViewModel())
}
*/
import SwiftUI

struct GroundingView: View {
    @ObservedObject var viewModel: GroundingViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        if viewModel.isTimeUp {
            TimeUpView(
                onRetry: viewModel.reset,
                onHome: { dismiss() }
            )
        } else if viewModel.isCompleted {
            CompletionView(
                onHome: { dismiss() },
                onTryAnother: viewModel.reset
            )
        } else {
            let step = viewModel.steps[viewModel.currentStepIndex]
            let currentAnswers = viewModel.answers[viewModel.currentStepIndex]
            let isStepFilled = !currentAnswers.contains(where: { $0.trimmingCharacters(in: .whitespaces).isEmpty })

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // ⬅️ Cancel + hide back
                        HStack {
                            Button("Cancel") {
                                dismiss()
                            }
                            .foregroundColor(Color("TextH2"))
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top)

                        // ⏱ الوقت - يمين
                        HStack {
                            Spacer()
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                    .foregroundColor(Color("lightpurple"))
                                Text(viewModel.formattedTime)
                                    .font(.system(size: 16))
                                    .foregroundColor(Color("lightpurple"))
                            }
                            .padding(.horizontal)
                        }

                        // 🔘 Progress bar
                        ProgressBarView(totalSteps: viewModel.steps.count, currentStep: viewModel.currentStepIndex)
                            .padding(.horizontal)

                        // 📝 السؤال
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

                        // ✍️ الحقول
                        ForEach(0..<step.count, id: \.self) { i in
                            TextField(i == 0 ? step.placeholder : "", text: viewModel.bindingForAnswer(stepIndex: viewModel.currentStepIndex, itemIndex: i))
                                .padding()
                                .background(Color("Textfield"))
                                .cornerRadius(8)
                                .padding(.horizontal)
                                .id(i) // Scroll target
                                .onTapGesture {
                                    withAnimation {
                                        proxy.scrollTo(i, anchor: .center)
                                    }
                                }
                        }

                        // ⏭ زر التالي
                        Button(action: {
                            viewModel.submitStep()
                        }) {
                            Text("Next step")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .background(isStepFilled ? Color("Button") : Color.gray.opacity(0.3))
                                .foregroundColor(Color("Textlight"))
                                .clipShape(Capsule())
                                .shadow(color: Color.white.opacity(isStepFilled ? 0.2 : 0), radius: 10, x: 0, y: 5)
                        }
                        .disabled(!isStepFilled)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)

                        Spacer(minLength: 50)
                    }
                }
                .ignoresSafeArea(.keyboard)
                .navigationBarBackButtonHidden(true) // ⛔️ يخفي زر Back تمامًا
                .onAppear {
                    viewModel.startTimer()
                }
            }
        }
    }
}

#Preview {
    GroundingView(viewModel: GroundingViewModel())
}
