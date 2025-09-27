//
//  TodoFormSheet.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 21/02/2021.
//

import SwiftUI

private struct TodoFormConfig {
    var title: String = ""
    var note: String = ""
}

struct TodoFormSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var formConfig = TodoFormConfig()

    func add() {
        modelContext.insert(TodoItem(title: formConfig.title, note: formConfig.note))
        dismiss()
    }

    func cancel() {
        dismiss()
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $formConfig.title.animation(.bouncy))
                ZStack(alignment: .topLeading) {
                    if formConfig.note.isEmpty {
                        Text("Note")
                            .foregroundStyle(.placeholder)
                            .opacity(0.5)
                            .allowsHitTesting(false)
                    }
                    TextEditor(text: $formConfig.note)
                        .padding(.horizontal, -4)
                        .padding(.vertical, -8)
                }
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancel) {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: add) {
                        Label("Done", systemImage: "checkmark")
                    }
                    .disabled(formConfig.title.isEmpty)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}
