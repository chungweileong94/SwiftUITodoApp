//
//  SwiftUITodoAppApp.swift
//  Shared
//
//  Created by White Room 02 on 20/02/2021.
//

import SwiftUI

@main
struct SwiftUITodoAppApp: App {
    @StateObject var todoStore = TodoStore()
    
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environmentObject(todoStore)
        }
    }
}
