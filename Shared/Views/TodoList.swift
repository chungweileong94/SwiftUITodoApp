//
//  TodoList.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 27/06/2021.
//

import SwiftUI

struct TodoList: View {
    @Binding var todoItems: [TodoItem]
    @Binding var editMode: EditMode
    let onDelete: (IndexSet) -> Void
    let onMove: (IndexSet, Int) -> Void

    var body: some View {
        List {
            ForEach($todoItems) { $item in
                TodoListItem(
                    title: item.title,
                    createAt: item.createAt,
                    isDone: $item.isDone,
                    showActions: editMode != .active
                )
            }
            .onDelete(perform: onDelete)
            .onMove(perform: onMove)
        }
        .listStyle(.insetGrouped)
        .environment(\.editMode, $editMode)
    }
}
