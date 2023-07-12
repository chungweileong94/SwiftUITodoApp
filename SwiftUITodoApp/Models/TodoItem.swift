//
//  TodoItem.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 11/07/2023.
//

import Foundation
import SwiftData

@Model
class TodoItem {
    @Attribute(.unique) var id: UUID
    var title: String
    var note: String
    var isDone: Bool
    var createdAt: Date

    init(title: String, note: String) {
        self.id = UUID()
        self.title = title
        self.note = note
        self.isDone = false
        self.createdAt = Date()
    }
}
