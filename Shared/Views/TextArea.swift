//
//  TextArea.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 21/02/2021.
//

import SwiftUI

struct TextArea: View {
    var title: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(title)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.vertical, 8)
            }
            TextEditor(text: $text)
                .padding(.trailing, -5)
                .offset(x: -5, y: 0)
                .frame(maxHeight: 140)
        }
    }
}
