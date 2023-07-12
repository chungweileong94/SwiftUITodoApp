//
//  TodoListView.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import LottieUI
import SwiftData
import SwiftUI

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var isTodoSheetPresented = false

    @Query(sort: \TodoItem.createdAt, order: .reverse, animation: .spring)
    private var todoItems: [TodoItem]

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
                if (todoItems.count) != 0 {
                    TodoList(
                        items: todoItems,
                        onDelete: { item in
                            modelContext.delete(item)
                        }
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
                    Button(action: addTodo) {
                        Label("New Todo", systemImage: "plus")
                    }.id(toolbarItemButtonID)
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

#Preview {
    TodoListView()
        .modelContainer(previewContainer)
}
