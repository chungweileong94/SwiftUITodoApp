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
    @Binding var editMode: EditMode
    var onDelete: (_ offsets: IndexSet) -> Void

    var incompleteItems: [TodoItem] {
        items.filter { !$0.isDone }
    }

    var completedItems: [TodoItem] {
        items.filter { $0.isDone }
    }

    var body: some View {
        List {
            ForEach(incompleteItems) { item in
                TodoListItem(
                    item: item,
                    showActions: editMode != .active
                )
            }
            .onDelete(perform: onDelete)

            Section((completedItems.count > 0) ? "Completed" : "") {
                ForEach(completedItems) { item in
                    TodoListItem(
                        item: item,
                        showActions: editMode != .active
                    )
                }
                .onDelete(perform: onDelete)
            }
        }
        .listStyle(.insetGrouped)
        .environment(\.editMode, $editMode)
    }
}
