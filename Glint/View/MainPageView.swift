import SwiftUI
import SwiftData
import Foundation
import WidgetKit

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

    var totalTodayText: String {
        let calendar = Calendar.current
        let todayEntries = entries.filter { calendar.isDateInToday($0.date) }
        let totalMinutes = todayEntries.reduce(0) { $0 + ($1.hours * 60) + $1.minutes }
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m today in daydreaming"
    }

    var body: some View {
        NavigationStack {
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
                    VStack(spacing: 4) {
                        Spacer().frame(height: 2)

                        HStack(spacing: 0) {
                            Picker("Hours", selection: $inputHours) {
                                ForEach(0..<25) { hour in
                                    Text("\(hour) h").bold().tag("\(hour.description)")
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 120, height: 90)
                            .clipped()

                            Picker("Minutes", selection: $inputMinutes) {
                                ForEach(0..<60) { min in
                                    Text("\(min) m").bold().tag("\(min.description)")
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 120, height: 90)
                            .clipped()
                        }

                        Button(action: {
                            let h = Int(inputHours) ?? 0
                            let m = Int(inputMinutes) ?? 0
                            let newEntryMinutes = h * 60 + m

                            let calendar = Calendar.current
                            let todayEntries = entries.filter { calendar.isDateInToday($0.date) }
                            let currentTotalMinutes = todayEntries.reduce(0) { $0 + $1.hours * 60 + $1.minutes }

                            if currentTotalMinutes + newEntryMinutes <= 1440 {
                                let entry = DaydreamEntry(hours: h, minutes: m)
                                modelContext.insert(entry)

                                let defaults = UserDefaults(suiteName: "group.com.rinad.Glint")
                                defaults?.set(h, forKey: "lastHours")
                                defaults?.set(m, forKey: "lastMinutes")

                                WidgetCenter.shared.reloadAllTimelines()
                                inputHours = "0"
                                inputMinutes = "0"
                            } else {
                                print("Exceeded daily limit of 24 hours.")
                            }
                        }) {
                            Text("Log")
                                .font(.body)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 28)
                                .background(Color.button)
                                .cornerRadius(14)
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                        }
                        .padding(.bottom, 0)
                    }
                    .frame(width: 320, height: 140)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )

                    Text("     How long were you daydreaming today?")
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

                    HStack(spacing: 16) {
    
                        NavigationLink(destination: BreathingView()) {
                            ActivityCard(title: "5-4-3-2-1 Technique", image: "face", description: "5 Steps | 2-5 min")
                        }
                        .buttonStyle(PlainButtonStyle())

                        NavigationLink(destination: CameraView()) {
                            ActivityCard(title: "Find Colors around you", image: "man", description: "1 Step | 2–3 min")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 32)
                }

                // الأداء مع الإجمالي
                VStack(alignment: .leading, spacing: 16) {
                    Text("Performance")
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(.horizontal, 32)

                    NavigationLink(destination: PerformanceView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.25, green: 0.2, blue: 0.7),
                                            Color(red: 0.1, green: 0.05, blue: 0.3)
                                        ]),
                                        startPoint: .top, endPoint: .bottom
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
                                Text(totalTodayText)
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, 32)
                            .padding(.bottom, 32)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .zIndex(1)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }

                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .padding(.top, 40)
        }
    }
}

// MARK: - ActivityCard Component
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

// Preview
#Preview {
    NavigationStack {
        MainPageView()
    }
}
