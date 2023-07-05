//
//  Todo.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import Foundation
import Observation

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var note: String = ""
    var isDone: Bool = false
    let createAt = Date()
}

@Observable class TodoStore {
    var items = [TodoItem]()
    var test = ""

    func addTodoItem(item: TodoItem) {
        items.append(item)
    }

    func deleteTodoItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func moveTodoItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}
