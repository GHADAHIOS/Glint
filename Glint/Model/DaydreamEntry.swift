import SwiftData
import Foundation
@Model
class DaydreamEntry {
    var hours: Int
    var minutes: Int
    var date: Date

    init(hours: Int, minutes: Int, date: Date = Date()) {
        self.hours = hours
        self.minutes = minutes
        self.date = date
    }
}
