import SwiftUI
import SwiftData

struct PerformanceView: View {
    @Query private var entries: [DaydreamEntry]

    private let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    private var dailyTotals: [String: Int] {
        var totals: [String: Int] = [:]
        let calendar = Calendar.current

        for entry in entries {
            let weekday = calendar.component(.weekday, from: entry.date) // Sunday = 1
            let daySymbol = calendar.shortWeekdaySymbols[weekday - 1]
            totals[daySymbol, default: 0] += entry.hours
        }

        return totals
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Performance")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color.purple)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                HStack(alignment: .bottom, spacing: 50) {
                    HStack(alignment: .bottom, spacing: 15) {
                        ForEach(days, id: \.self) { day in
                            let total = dailyTotals[day] ?? 0
                            VStack(spacing: 6) {
                                Text(emoji(for: total))
                                    .font(.system(size: 20))
                                Rectangle()
                                    .fill(color(for: total))
                                    .frame(width: 20, height: CGFloat(total) * 10)
                                    .cornerRadius(4)
                                Text(day)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }

                    VStack(alignment: .trailing, spacing: 16) {
                        ForEach((0...6).reversed(), id: \.self) { i in
                            Text("\(i * 4)h")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                                .frame(height: 28)
                        }
                    }
                    .padding(.leading, 4)
                }
                .frame(height: 280)
                .padding(.horizontal)

                HStack(spacing: 16) {
                    StatCardView(
                        title: "Weekly Change",
                        value: "-26%",
                        icon: "chart.line.downtrend.xyaxis",
                        iconColor: .red,
                        valueColor: .red
                    )
                    StatCardView(
                        title: "Today’s daydreaming",
                        value: todayEntryText,
                        emoji: emoji(for: todayHours)
                    )
                }
                .padding(.top, 32)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }

    private var todayHours: Int {
        let calendar = Calendar.current
        return entries.filter { calendar.isDateInToday($0.date) }
            .map { $0.hours }
            .reduce(0, +)
    }

    private var todayEntryText: String {
        let calendar = Calendar.current
        let todayEntries = entries.filter { calendar.isDateInToday($0.date) }
        let totalMinutes = todayEntries.reduce(0) { $0 + $1.hours * 60 + $1.minutes }
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
    }

    private func emoji(for hours: Int) -> String {
        switch hours {
        case 0: return "😐"
        case 1...3: return "☹️"
        case 4...6: return "😯"
        case 7...9: return "😠"
        case 10...12: return "😡"
        case 13...15: return "😤"
        default: return "😊"
        }
    }

    private func color(for hours: Int) -> Color {
        switch hours {
        case 0...2: return .yellow
        case 3...6: return .orange
        case 7...10: return .red
        default: return .green
        }
    }
}

struct StatCardView: View {
    var title: String
    var value: String
    var icon: String? = nil
    var emoji: String? = nil
    var iconColor: Color = .primary
    var valueColor: Color = .primary

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)

            Text(value)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(valueColor)

            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(iconColor)
            }

            if let emoji = emoji {
                Text(emoji)
                    .font(.system(size: 32))
            }
        }
        .frame(width: 160, height: 150)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}
struct PerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceView()
    }
}
