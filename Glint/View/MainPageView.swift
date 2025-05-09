import SwiftUI
import SwiftData

// MARK: - شكل الزوايا اليمنى فقط
struct RoundedCorners: Shape {
    var radius: CGFloat = 25
    var corners: UIRectCorner = [.topRight, .bottomRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - MainPageView
struct MainPageView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [DaydreamEntry]
    
    @State private var inputHours = ""
    @State private var inputMinutes = ""

    var totalTimeText: String {
        guard let last = entries.last else { return "0h 0m today in daydreaming" }
        return "\(last.hours)h \(last.minutes)m today in daydreaming"
    }

    var body: some View {
        VStack(spacing: 40) {
            // العنوان
            VStack(alignment: .leading, spacing: 4) {
                Text("Hey !")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textH1)

                Text("Tracking daydreams Journal")
                    .font(.body)
                    .foregroundColor(.black)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 32)

            // إدخال الوقت
            ZStack(alignment: .topLeading) {
                VStack(spacing: 6) {
                    Spacer().frame(height: 12)

                    HStack(spacing: 40) {
                        TextField("0 hours", text: $inputHours)
                            .keyboardType(.numberPad)
                            .frame(width: 60)
                            .multilineTextAlignment(.center)
                            .font(.callout)
                            .fontWeight(.semibold)

                        TextField("0 min", text: $inputMinutes)
                            .keyboardType(.numberPad)
                            .frame(width: 60)
                            .multilineTextAlignment(.center)
                            .font(.callout)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 4)
                    .background(Color.darkgray)
                    .cornerRadius(12)

                    Button(action: {
                        let h = Int(inputHours) ?? 0
                        let m = Int(inputMinutes) ?? 0
                        let entry = DaydreamEntry(hours: h, minutes: m)
                        modelContext.insert(entry)
                        inputHours = ""
                        inputMinutes = ""
                    }) {
                        Text("Log")
                            .font(.body)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 28)
                            .background(Color.button)
                            .cornerRadius(14)
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 6)
                }
                .frame(width: 320, height: 100)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )

                Text("How long were you daydreaming today?")
                    .font(.callout)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .frame(width: 360, height: 34, alignment: .leading)
                    .background(
                        RoundedCorners(radius: 25, corners: [.topRight, .bottomRight])
                            .fill(Color.candypurple)
                    )
                    .offset(x: -33, y: -17)
            }

            // الأنشطة
            VStack(alignment: .leading, spacing: 16) {
                Text("Activity")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.horizontal, 32)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        // البطاقة الأولى
                        ZStack(alignment: .topTrailing) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 8) {
                                    Text("5-4-3-2-1 Technique")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Image("face")
                                        .foregroundColor(.white.opacity(0.6))
                                }

                                Spacer()

                                HStack(spacing: 6) {
                                    Text("5 Steps | 3–5 min")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .padding(.bottom, 4)
                            }
                            .padding()
                            .frame(width: 170, height: 183)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color(red: 0.75, green: 0.6, blue: 1.0), Color.lightpurple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                        }

                        // البطاقة الثانية
                        ZStack(alignment: .topTrailing) {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack(spacing: 8) {
                                    Text("Find Colors around you")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Image("man")
                                        .foregroundColor(.white.opacity(0.6))
                                }

                                Spacer()

                                HStack(spacing: 6) {
                                    Text("1 Step | 2–3 min")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.9))
                                }
                                .padding(.bottom, 4)
                            }
                            .padding()
                            .frame(width: 170, height: 183)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color(red: 0.75, green: 0.6, blue: 1.0), Color.lightpurple]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }

            // أداء اليوم
            VStack(alignment: .leading, spacing: 16) {
                Text("Performance")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.horizontal, 32)

                ZStack {
                    // الخلفية
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.25, green: 0.2, blue: 0.7),
                                    Color(red: 0.1, green: 0.05, blue: 0.3)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        .frame(width: 357, height: 149)

                    // زخرفة الصور
                    ZStack {
                        Image("overly3")
                            .resizable()
                            .scaledToFit()

                        Image("overly2")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: 357, height: 60)
                    .opacity(0.9)
                    .offset(y: 45)
                    .zIndex(0)

                    // النصوص
                    VStack(alignment: .leading, spacing: 6) {
                        Text("you Spent")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))

                        Text(totalTimeText)
                            .font(.body)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 24)
                    .padding(.bottom, 42)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .zIndex(1)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }

            Spacer()
        }
        .padding(.top, 40)
    }
}

#Preview {
    MainPageView()
}
