import SwiftUI
import SwiftData
import Foundation

// MARK: - نموذج البيانات

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

    @State private var inputHours = "0"
    @State private var inputMinutes = "0"

    var totalTimeText: String {
        let calendar = Calendar.current
        let todayEntries = entries.filter { calendar.isDateInToday($0.date) }
        let totalMinutes = todayEntries.reduce(0) { $0 + $1.hours * 60 + $1.minutes }
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m today in daydreaming"
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
                        Picker("Hours", selection: $inputHours) {
                            ForEach(0..<25) { hour in
                                Text("\(hour) h").tag("\(hour.description)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 80, height: 100)

                        Picker("Minutes", selection: $inputMinutes) {
                            ForEach(0..<60) { min in
                                Text("\(min) m").tag("\(min.description)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 80, height: 100)
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
                        inputHours = "0"
                        inputMinutes = "0"
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
                .frame(width: 320, height: 180)
                .background(Color.gray.opacity(0.1))
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
                        ActivityCard(
                            title: "5-4-3-2-1 Technique",
                            image: "face",
                            description: "5 Steps | 3–5 min"
                        )
                        ActivityCard(
                            title: "Find Colors around you",
                            image: "man",
                            description: "1 Step | 2–3 min"
                        )
                    }
                    .padding(.horizontal, 32)
                }
            }

            // الأداء
            VStack(alignment: .leading, spacing: 16) {
                Text("Performance")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(.horizontal, 32)

                ZStack {
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

// MARK: - Activity Card View
struct ActivityCard: View {
    let title: String
    let image: String
    let description: String

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(image)
                        .foregroundColor(.white.opacity(0.6))
                }

                Spacer()

                HStack(spacing: 6) {
                    Text(description)
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
                            gradient: Gradient(colors: [Color.lightpurple, Color.button]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
        }
    }
}

// MARK: - Preview
#Preview {
    MainPageView()
}
