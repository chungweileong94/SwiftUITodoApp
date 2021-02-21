//
//  TodoFormSheet.swift
//  SwiftUITodoApp
//
//  Created by White Room 02 on 21/02/2021.
//

import SwiftUI

private struct TodoFormConfig {
    var title: String = ""
    var note: String = ""
}

struct TodoFormSheet: View {
    @Binding var isPresented: Bool
    @State private var formConfig = TodoFormConfig()
    @EnvironmentObject private var todoStore: TodoStore

    func dismiss() {
        isPresented = false
    }

    func add() {
        todoStore.addTodoItem(item: TodoItem(title: formConfig.title, note: formConfig.note))
        dismiss()
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $formConfig.title)
                ZStack(alignment: .topLeading) {
                    if formConfig.note.isEmpty {
                        Text("Note")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .padding(.vertical, 8)
                    }
                    TextEditor(text: $formConfig.note)
                        .padding(.trailing, -5)
                        .offset(x: -5, y: 0)
                        .frame(maxHeight: 140)
                }
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: dismiss) {
                        Text("Cancel")
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(action: add) {
                        Text("Add")
                    }
                    .disabled(formConfig.title.count < 1)
                }
            }
        }
    }
}
