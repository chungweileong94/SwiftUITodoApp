//
//  TodoListView.swift
//  SwiftUITodoApp (iOS)
//
//  Created by White Room 02 on 20/02/2021.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var todoStore: TodoStore
    @State private var isTodoSheetPresented = false
    @State private var editMode = EditMode.inactive

    func addTodo() {
        isTodoSheetPresented.toggle()
    }

    var body: some View {
        NavigationView {
            TodoList(
                todoItems: $todoStore.items,
                editMode: $editMode,
                onDelete: todoStore.deleteTodoItems,
                onMove: todoStore.moveTodoItem
            )
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    showViewIf(editMode != .active) {
                        Button(action: addTodo) {
                            Label("New Todo", systemImage: "plus")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(editMode == .active ? "Done" : "Edit") {
                        withAnimation {
                            editMode = editMode == .active ? .inactive : .active
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isTodoSheetPresented) {
            TodoFormSheet(isPresented: $isTodoSheetPresented)
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environmentObject(TodoStore())
    }
}
