//
//  TodoListView.swift
//  SwiftUITodoApp (iOS)
//
//  Created by White Room 02 on 20/02/2021.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var todoStore: TodoStore
    
    func addTodo() {
        todoStore.addTodoItem(item: TodoItem(title: "New Todo Item"))
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
                        Label("Add", systemImage: "plus")
                    }
                }
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


