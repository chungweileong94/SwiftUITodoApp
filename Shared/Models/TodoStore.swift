//
//  Todo.swift
//  SwiftUITodoApp (iOS)
//
//  Created by White Room 02 on 20/02/2021.
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
}

class TodoStore: ObservableObject {
    @Published var items = [TodoItem]()
    
    func addTodoItem(item: TodoItem) {
        items.append(item)
    }
    
    func removeTodoItem(itemId: UUID) {
        items = items.filter { (item) -> Bool in
            item.id == itemId
        }
    }
}
