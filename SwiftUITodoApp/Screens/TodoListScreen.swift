//
//  TodoListView.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import LottieUI
import SwiftData
import SwiftUI

struct SectionHeader: View {
    private var text: String?

    init(_ text: String?) {
        self.text = text
    }

    var body: some View {
        if let text = text {
            Text(text)
                .textCase(nil)
                .font(.headline)
                .foregroundColor(.primary)
        } else {
            EmptyView()
        }
    }
}

struct TodoListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isTodoSheetPresented = false

    @Query(
        filter: #Predicate { !$0.isDone },
        sort: \TodoItem.createdAt,
        order: .reverse,
        animation: .spring
    )
    private var incompletedItems: [TodoItem]

    @Query(
        filter: #Predicate { $0.isDone },
        sort: \TodoItem.createdAt,
        order: .reverse,
        animation: .spring
    )
    private var completedItems: [TodoItem]

    func addItem() {
        isTodoSheetPresented.toggle()
    }

    func deleteItem(item: TodoItem) {
        modelContext.delete(item)
    }

    var body: some View {
        NavigationStack {
            Group {
                if incompletedItems.count > 0 || completedItems.count > 0 {
                    List {
                        Section(header: SectionHeader((incompletedItems.count > 0) ? "In Progress" : nil)) {
                            ForEach(incompletedItems) {
                                TodoListItem(item: $0, onDelete: deleteItem)
                            }
                        }

                        Section(header: SectionHeader((completedItems.count > 0) ? "Completed" : nil)) {
                            ForEach(completedItems) {
                                TodoListItem(item: $0, onDelete: deleteItem)
                            }
                        }
                    }
                } else {
                    // Empty view
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
                        Button(action: addItem) {
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
            .navigationTitle("My Todos")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: addItem) {
                        Label("New Todo", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isTodoSheetPresented) {
            TodoFormSheet()
        }
    }
}

#Preview {
    TodoListScreen()
        .modelContainer(previewContainer)
}
