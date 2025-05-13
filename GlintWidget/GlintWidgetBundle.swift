//
//  GlintWidgetBundle.swift
//  GlintWidget
//
//  Created by Renad Alotaibi on 12/11/1446 AH.
//

import WidgetKit
import SwiftUI

@main
struct GlintWidgetBundle: WidgetBundle {
    var body: some Widget {
        GlintWidget()
        GlintWidgetControl()
        GlintWidgetLiveActivity()
    }
}
