import Foundation

struct TaskModel: Codable {
    let name: String
    var lessons: [LessonModel]
    let progress: Float
}
