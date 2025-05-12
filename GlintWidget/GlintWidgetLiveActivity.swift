//
//  GlintWidgetLiveActivity.swift
//  GlintWidget
//
//  Created by Renad Alotaibi on 12/11/1446 AH.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct GlintWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct GlintWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: GlintWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension GlintWidgetAttributes {
    fileprivate static var preview: GlintWidgetAttributes {
        GlintWidgetAttributes(name: "World")
    }
}

extension GlintWidgetAttributes.ContentState {
    fileprivate static var smiley: GlintWidgetAttributes.ContentState {
        GlintWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: GlintWidgetAttributes.ContentState {
         GlintWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: GlintWidgetAttributes.preview) {
   GlintWidgetLiveActivity()
} contentStates: {
    GlintWidgetAttributes.ContentState.smiley
    GlintWidgetAttributes.ContentState.starEyes
}
