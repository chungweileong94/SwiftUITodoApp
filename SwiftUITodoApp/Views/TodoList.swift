//
//  TodoList.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 27/06/2021.
//

import SwiftData
import SwiftUI

struct TodoList: View {
    @Environment(\.modelContext) private var modelContext
    var items: [TodoItem]
    var onDelete: (_ item: TodoItem) -> Void

    var incompleteItems: [TodoItem] {
        items.filter { !$0.isDone }
    }

    var completedItems: [TodoItem] {
        items.filter { $0.isDone }
    }

    var body: some View {
        List {
            ForEach(incompleteItems) {
                TodoListItem(item: $0, onDelete: onDelete)
            }

            Section((completedItems.count > 0) ? "Completed" : "") {
                ForEach(completedItems) {
                    TodoListItem(item: $0, onDelete: onDelete)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}
