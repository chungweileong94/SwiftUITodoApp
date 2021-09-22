//
//  TodoListItem.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import SwiftUI

struct TodoListItem: View {
    var title: String
    var createAt: Date
    @Binding var isDone: Bool
    var showActions: Bool = true

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    var body: some View {
        HStack {
            if showActions {
                CheckBox(isChecked: $isDone)
            }
            VStack(alignment: .leading) {
                Text(title)
                    .strikethrough(isDone)
                    .lineLimit(1)
                if showActions {
                    Text("\(createAt, formatter: Self.dateFormatter)")
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
    @State var item = TodoItem(title: "Todo Iten 1")

    var body: some View {
        TodoListItem(
            title: item.title,
            createAt: item.createAt,
            isDone: $item.isDone
        ).padding()
    }
}

struct TodoListItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItem_PreviewsController()
            .previewLayout(.sizeThatFits)
    }
}
#endif
