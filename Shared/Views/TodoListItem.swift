//
//  TodoListItem.swift
//  SwiftUITodoApp
//
//  Created by White Room 02 on 20/02/2021.
//

import SwiftUI

struct TodoListItem: View {
    var title: String
    @Binding var isDone: Bool
    
    var body: some View {
        CheckBox(isChecked: $isDone) {
            Text(title)
                .strikethrough(isDone)
                .lineLimit(1)
            Spacer()
        }
        .padding()
    }
}

#if DEBUG
struct TodoListItem_PreviewsController: View {
    @State var item = TodoItem(title: "Todo Iten 1");
    
    var body: some View {
        TodoListItem(title: item.title, isDone: $item.isDone)
    }
}

struct TodoListItem_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItem_PreviewsController()
            .previewLayout(.sizeThatFits)
    }
}
#endif
