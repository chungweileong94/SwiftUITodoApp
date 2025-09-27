//
//  TodoListView.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import Lottie
import SwiftData
import SwiftUI

struct SectionHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textCase(nil)
            .font(.headline)
            .foregroundColor(.primary)
    }
}

struct TodoListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isTodoSheetPresented = false

    @Query(
        sort: [SortDescriptor(\TodoItem.createdAt, order: .reverse)]
    )
    private var items: [TodoItem]

    private var incompletedItems: [TodoItem] {
        items.filter { $0.isDone == false }
    }

    private var completedItems: [TodoItem] {
        items.filter { $0.isDone == true }
    }

    private var hasIncompletedItems: Bool { incompletedItems.count > 0 }
    private var hasCompletedItems: Bool { completedItems.count > 0 }
    private var hasItems: Bool { hasIncompletedItems || hasCompletedItems }

    func addItem() {
        isTodoSheetPresented.toggle()
    }

    func deleteItem(item: TodoItem) {
        modelContext.delete(item)
    }

    var body: some View {
        NavigationStack {
            Group {
                if hasItems {
                    List {
                        if hasIncompletedItems {
                            Section(header: Text("In Progress").modifier(SectionHeaderModifier())) {
                                ForEach(incompletedItems, id: \.id) {
                                    TodoListItem(item: $0, onDelete: deleteItem)
                                }
                            }
                        }

                        if hasCompletedItems {
                            Section(header: Text("Completed").modifier(SectionHeaderModifier())) {
                                ForEach(completedItems, id: \.id) {
                                    TodoListItem(item: $0, onDelete: deleteItem)
                                }
                            }
                        }
                    }
                } else {
                    emptyView
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

    var emptyView: some View {
        VStack {
            Spacer()
            #warning("TODO: Migrate package to lottie-spam, once it supports SwiftUI")
            LottieView(animation: .named("Empty"))
                .resizable()
                .looping()
                .frame(maxHeight: 200)
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

#Preview {
    TodoListScreen()
        .modelContainer(previewContainer)
}
