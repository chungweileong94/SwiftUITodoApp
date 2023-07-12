//
//  TodoListItem.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import SwiftUI

struct TodoListItem: View {
    @Bindable var item: TodoItem
    var showActions: Bool = true

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    var body: some View {
        HStack {
            if showActions {
                Button(action: {
                    withAnimation { item.isDone.toggle() }
                }) {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 24))
                        .foregroundColor(item.isDone ? .green : .gray)
                }
            }
            VStack(alignment: .leading) {
                Text(item.title)
                    .strikethrough(item.isDone)
                    .lineLimit(1)
                if showActions {
                    Text("\(item.createdAt, formatter: Self.dateFormatter)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#if DEBUG
    struct TodoListItem_PreviewsController: View {
        @State var item = TodoItem(title: "Todo Iten 1", note: "")

        var body: some View {
            TodoListItem(item: item)
                .padding()
        }
    }

    #Preview {
        TodoListItem_PreviewsController()
            .previewLayout(.sizeThatFits)
    }
#endif
