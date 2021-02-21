//
//  TodoListItem.swift
//  SwiftUITodoApp
//
//  Created by White Room 02 on 20/02/2021.
//

import SwiftUI

struct TodoListItem: View {
    var title: String
    var createAt: Date
    @Binding var isDone: Bool

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    var body: some View {
        CheckBox(isChecked: $isDone) {
            VStack(alignment: .leading) {
                Text(title)
                    .strikethrough(isDone)
                    .lineLimit(1)
                Text("\(createAt, formatter: Self.dateFormatter)")
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 12)
    }
}

#if DEBUG
struct TodoListItem_PreviewsController: View {
    @State var item = TodoItem(title: "Todo Iten 1")

    var body: some View {
        TodoListItem(title: item.title, createAt: item.createAt, isDone: $item.isDone)
    }
}

struct TodoListItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItem_PreviewsController()
            .previewLayout(.sizeThatFits)
    }
}
#endif
