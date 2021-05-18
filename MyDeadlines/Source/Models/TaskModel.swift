//
//  TaskModel.swift
//  MyDeadlines
//
//  Created by Oleh Derkachov on 11.05.2021.
//

import Foundation


struct TaskModel {
    let name: String
    let labs: Int
    let practical: Int
    let total: [LessonModel]
}
