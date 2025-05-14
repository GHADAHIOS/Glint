

//Done by Hajar ⭐️

import SwiftUI

struct BreathingView: View {
    @StateObject private var viewModel = BreathingViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color("BGbase").ignoresSafeArea()

                VStack {
                    Spacer()

                    Text(viewModel.breathText)
                        .font(.system(size: 36, weight: .semibold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color("TextH2"), Color("Button")],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .multilineTextAlignment(.center)
                        .scaleEffect(viewModel.animateText ? 1.05 : 0.95)
                        .opacity(viewModel.animateText ? 1 : 0.2)
                        .animation(.easeInOut(duration: 0.8), value: viewModel.animateText)
                        .padding(.bottom, 30)

                    ZStack {
                        ForEach(0...2, id: \.self) { i in
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.purple, .white]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 150, height: 150)
                                    .offset(y: viewModel.startAnimation ? 75 : 0)

                                Circle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.purple, .white]),
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                    )
                                    .frame(width: 150, height: 150)
                                    .offset(y: viewModel.startAnimation ? -75 : 0)
                            }
                            .opacity(0.5)
                            .rotationEffect(.degrees(viewModel.startAnimation ? Double(i * 60) : 0))
                            .scaleEffect(viewModel.startAnimation ? 1 : 0.2)
                        }
                    }
                    .frame(width: 300, height: 300)
                    .onAppear {
                        viewModel.start()
                    }

                    Spacer()

                    NavigationLink(destination: GroundingView(viewModel: GroundingViewModel())) {
                        Text("Ready")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(
                                LinearGradient(
                                    colors: [Color("Button"), Color("Button")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 5)
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                            .scaleEffect(1.02)
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    BreathingView()
}
