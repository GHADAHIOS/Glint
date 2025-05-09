import SwiftData
import Foundation
// MARK: - نموذج البيانات
@Model
class DaydreamEntry {
    var date: Date
    var hours: Int
    var minutes: Int

    init(hours: Int, minutes: Int, date: Date = Date()) {
        self.hours = hours
        self.minutes = minutes
        self.date = date
    }
}
