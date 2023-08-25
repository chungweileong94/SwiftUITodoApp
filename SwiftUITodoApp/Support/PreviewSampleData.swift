//
//  PreviewSampleData.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 12/07/2023.
//

import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: TodoItem.self
        )
        container.mainContext.insert(TodoItem(title: "Item 1", note: "Item 1"))
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
