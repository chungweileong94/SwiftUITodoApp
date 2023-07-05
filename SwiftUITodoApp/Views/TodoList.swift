//
//  TodoList.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 27/06/2021.
//

import SwiftUI

struct TodoList: View {
    @Bindable var store: TodoStore
    @Binding var editMode: EditMode

    var body: some View {
        List {
            ForEach($store.items) { $item in
                TodoListItem(
                    title: item.title,
                    createAt: item.createAt,
                    isDone: $item.isDone,
                    showActions: editMode != .active
                )
            }
            .onDelete(perform: store.deleteTodoItems)
            .onMove(perform: store.moveTodoItem)
        }
        .listStyle(.insetGrouped)
        .environment(\.editMode, $editMode)
    }
}
