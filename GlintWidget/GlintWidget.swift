//
//  GlintWidget.swift
//  GlintWidget
//
//  Created by Renad Alotaibi on 12/11/1446 AH.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), totalMinutes: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let total = fetchTotalMinutes()
        completion(SimpleEntry(date: Date(), totalMinutes: total))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let total = fetchTotalMinutes()
        let entry = SimpleEntry(date: Date(), totalMinutes: total)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

    private func fetchTotalMinutes() -> Int {
        let defaults = UserDefaults(suiteName: "group.com.rinad.Glint")
        
        let hours = defaults?.integer(forKey: "lastHours") ?? 0
        let minutes = defaults?.integer(forKey: "lastMinutes") ?? 0
        
        print(" Widget fetched: \(hours)h \(minutes)m")
        
        return (hours * 60) + minutes
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let totalMinutes: Int
}

struct GlintWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    // نص Daydream Time مع حجم خط قابل للتعديل بناءً على أصغر حجم للودجيت
                    Text("Daydream Time")
                        .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.12)) // أصغر حجم بين العرض والارتفاع
                        .foregroundColor(.white)

                    // المربع حول الرقم
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.3)) // لون المربع مع الشفافية
                        .frame(height: min(geometry.size.height, geometry.size.width) * 0.3) // ارتفاع المربع بناءً على أصغر حجم
                        .overlay(
                            Text("\(entry.totalMinutes / 60) h \(entry.totalMinutes % 60) m")
                                .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.15)) // حجم الخط بناءً على أصغر حجم للودجيت
                                .bold()
                                .foregroundColor(.white)
                        )

                    Spacer()
                }
                .padding()
            }
        }
        .containerBackground(for: .widget) {
            LinearGradient(
                gradient: Gradient(colors: [Color("lightpurple"), Color("lightpurple")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}


struct GlintWidget: Widget {
    let kind: String = "GlintWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GlintWidgetEntryView(entry: entry)
        }

        .configurationDisplayName("Daydream Logger")
        .description("Pick how long you daydreamed today.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}



