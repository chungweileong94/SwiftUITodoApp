//
//  TodoListView.swift
//  SwiftUITodoApp (iOS)
//
//  Created by White Room 02 on 20/02/2021.
//

import SwiftUI

struct TodoListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var todoStore: TodoStore
    @State private var isTodoSheetPresented = false
    @State private var editMode = EditMode.inactive
    
    /**
     This state is to workaround the bug where the toolbar button become un-pressable after closing the sheet
     https://stackoverflow.com/questions/60485329/swiftui-modal-presentation-works-only-once-from-navigationbaritems/60492031#60492031
     */
    @State private var toolbarItemButtonID = UUID()

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
            .navigationTitle("Todo Items")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if editMode != .active {
                        Button(action: addTodo) {
                            Label("New Todo", systemImage: "plus")
                        }.id(toolbarItemButtonID)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if todoStore.items.count != 0 {
                        Button(editMode == .active ? "Done" : "Edit") {
                            withAnimation {
                                editMode = editMode == .active ? .inactive : .active
                            }
                        }.id(toolbarItemButtonID)
                    }
                }
            }
        }
        .sheet(isPresented: $isTodoSheetPresented) {
            TodoFormSheet().onDisappear {
                toolbarItemButtonID = UUID()
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environmentObject(TodoStore())
    }
}
