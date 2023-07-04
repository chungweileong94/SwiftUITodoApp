//
//  TodoListView.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import LottieUI
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
        NavigationStack {
            Group {
                if ($todoStore.items.count) != 0 {
                    TodoList(
                        todoItems: $todoStore.items,
                        editMode: $editMode,
                        onDelete: todoStore.deleteTodoItems,
                        onMove: todoStore.moveTodoItem
                    )
                } else {
                    VStack {
                        Spacer()
                        LottieView(state: LUStateData(type: .name("Empty", Bundle.main), loopMode: .loop))
                            .frame(height: 200)
                            .padding(.horizontal)
                        Text("Looks like nothing here")
                            .font(.headline)
                            .padding(.bottom, 1)
                        Text("Add some todos now!")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Button(action: addTodo) {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                Text("Add").fontWeight(.bold)
                                Spacer()
                            }.padding(.horizontal).padding(.vertical, 8)
                        }
                        .buttonStyle(BorderedProminentButtonStyle()).padding(.horizontal)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Todo List")
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
