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
    
    func addTodo() {
        isTodoSheetPresented.toggle()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(todoStore.items.enumerated()), id: \.element.id) { (index, item) in
                    TodoListItem(title: item.title, isDone: $todoStore.items[index].isDone)
                }
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addTodo) {
                        Label("New Todo", systemImage: "plus")
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


