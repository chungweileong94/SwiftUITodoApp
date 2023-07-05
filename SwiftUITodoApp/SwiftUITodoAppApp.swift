//
//  SwiftUITodoAppApp.swift
//  Shared
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import SwiftUI

@main
struct SwiftUITodoAppApp: App {
    @State private var todoStore = TodoStore()

    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environment(todoStore)
        }
    }
}
