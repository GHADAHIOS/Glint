import SwiftUI

struct PerformanceView: View {
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let hours: [CGFloat] = [2, 4, 8, 14, 18, 22, 1]
    let colors: [Color] = [
        .yellow,
        .yellow.opacity(0.8),
        .orange,
        .orange.opacity(0.9),
        .red,
        .red.opacity(0.9),
        .green
    ]
    let emojis = ["😐", "☹️", "😯", "😠", "😡", "😤", "😊"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // زر العودة
                Text("Back")
                    .foregroundColor(Color(#colorLiteral(red: 0.274, green: 0.188, blue: 0.682, alpha: 1)))
                    .padding(.leading)

                // العنوان
                Text("Performance")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color(#colorLiteral(red: 0.274, green: 0.188, blue: 0.682, alpha: 1)))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // الرسم البياني
                HStack(alignment: .bottom, spacing: 50) {
                    // الأعمدة
                    HStack(alignment: .bottom, spacing: 15) {
                        ForEach(0..<days.count, id: \.self) { index in
                            VStack(spacing: 6) {
                                Text(emojis[index])
                                    .font(.system(size: 20))

                                Rectangle()
                                    .fill(colors[index])
                                    .frame(width: 20, height: hours[index] * 10)
                                    .cornerRadius(4)

                                Text(days[index])
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                        }
                    }

                    // المحور Y على اليمين
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
                    StatCardView(
                        title: "Weekly Change",
                        value: "-26%",
                        icon: "chart.line.downtrend.xyaxis",
                        iconColor: .red,
                        valueColor: .red
                    )

                    StatCardView(
                        title: "Today’s daydreaming",
                        value: "0h 52m",
                        emoji: "😐"
                    )
                }
                .padding(.top, 32)
                .padding(.horizontal)
            }
            .padding(.vertical)
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
