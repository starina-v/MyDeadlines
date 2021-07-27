import Foundation

struct LessonModel: Codable {
    let name: String
    let deadline: Date
    var isFinished: Bool
}
