//
//  SwiftUITodoAppApp.swift
//  Shared
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import SwiftUI

@main
struct SwiftUITodoAppApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .modelContainer(for: [TodoItem.self])
        }
    }
}
