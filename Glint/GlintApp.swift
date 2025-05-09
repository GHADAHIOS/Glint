import SwiftUI
import SwiftData

@main
struct GlintApp: App {
    var body: some Scene {
        WindowGroup {
            MainPageView()
        }
        .modelContainer(for: DaydreamEntry.self)
    }
}
