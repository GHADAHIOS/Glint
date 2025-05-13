import SwiftUI
import SwiftData

struct PerformanceView: View {
    @Query private var entries: [DaydreamEntry]

    private let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    // تجميع إجمالي الساعات لكل يوم من الأسبوع
    private var dailyTotals: [String: Int] {
        var totals: [String: Int] = [:]
        let calendar = Calendar.current

        for entry in entries {
            let weekday = calendar.component(.weekday, from: entry.date)
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

                // الرسم البياني
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

                    // المحور Y
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

                // البطاقات السفلية
                HStack(spacing: 16) {
                    // متوسط الأسبوع
                    StatCardView(
                        title: "Weekly Average",
                        value: weeklyAverageText,
                        icon: "chart.bar.fill",
                        iconColor: .blue,
                        valueColor: .blue
                    )

                    // بيانات اليوم
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

    // إجمالي ساعات اليوم
    private var todayHours: Int {
        let calendar = Calendar.current
        return entries
            .filter { calendar.isDateInToday($0.date) }
            .map { $0.hours }
            .reduce(0, +)
    }

    // ساعات ودقائق اليوم
    private var todayEntryText: String {
        let calendar = Calendar.current
        let todayEntries = entries.filter { calendar.isDateInToday($0.date) }
        let totalMinutes = todayEntries.reduce(0) { $0 + $1.hours * 60 + $1.minutes }
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(minutes)m"
    }

    // متوسط الأسبوع
    private var weeklyAverageText: String {
        let calendar = Calendar.current
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -6, to: Date()) else { return "0h 0m" }

        let recentEntries = entries.filter { $0.date >= sevenDaysAgo }
        let totalMinutes = recentEntries.reduce(0) { $0 + $1.hours * 60 + $1.minutes }
        let averageMinutes = totalMinutes / 7
        let hours = averageMinutes / 60
        let minutes = averageMinutes % 60
        return "\(hours)h \(minutes)m"
    }

    // الإيموجي حسب عدد الساعات
    private func emoji(for hours: Int) -> String {
        switch hours {
        case 0...1: return "😌"
        case 2...4: return "😐"
        case 5...8: return "🙁"
        case 9...12: return "😯"
        case 13...16: return "😠"
        case 17...20: return "😡"
        case 21...24: return "😤"
        default: return "😤"
        }
    }

    // اللون حسب عدد الساعات
    private func color(for hours: Int) -> Color {
        switch hours {
        case 0...1: return .green4
        case 2...4: return .yellow4
        case 5...8: return .darkyallow
        case 9...12: return .lightorange
        case 13...16: return .darkOrange
        case 17...20: return .lightred
        case 21...24: return .darkred
        default: return .green
        }
    }
}

// بطاقة الأداء
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

#Preview {
    PerformanceView()
}
