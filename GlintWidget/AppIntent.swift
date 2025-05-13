//
//  AppIntent.swift
//  GlintWidget
//
//  Created by Renad Alotaibi on 12/11/1446 AH.
//

import WidgetKit
import AppIntents

struct LogDaydreamIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Log Daydream Duration"

    @Parameter(title: "Hours")
    var hours: Int?

    @Parameter(title: "Minutes")
    var minutes: Int?

    static var parameterSummary: some ParameterSummary {
        Summary("Log \(\.$hours) hrs \(\.$minutes) min")
    }
}
