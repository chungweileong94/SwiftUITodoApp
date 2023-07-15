//
//  TodoListItem.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import SwiftUI

struct TodoListItem: View {
    @Bindable var item: TodoItem
    var onDelete: (_ item: TodoItem) -> Void

    static let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    func toggleDoneStatus() {
        withAnimation { item.isDone.toggle() }
    }

    var body: some View {
        HStack {
            Button(action: toggleDoneStatus) {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(item.isDone ? .green : .gray)
            }
            VStack(alignment: .leading) {
                Text(item.title)
                    .strikethrough(item.isDone)
                    .lineLimit(1)
                Text("\(item.createdAt, formatter: Self.dateFormatter)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .swipeActions {
            Button("Delete", role: .destructive) { onDelete(item) }
        }
    }
}

#if DEBUG
    struct TodoListItem_PreviewsController: View {
        @State var item = TodoItem(title: "Todo Iten 1", note: "")

        var body: some View {
            TodoListItem(item: item, onDelete: { _ in })
                .padding()
        }
    }

    #Preview {
        TodoListItem_PreviewsController()
            .previewLayout(.sizeThatFits)
    }
#endif
