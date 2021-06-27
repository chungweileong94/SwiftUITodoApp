//
//  view.swift
//  SwiftUITodoApp (iOS)
//
//  Created by Chung Wei Leong on 27/06/2021.
//

import SwiftUI

func showViewIf<Content: View>(_ condition: Bool, content: () -> Content) -> some View {
    if condition {
        return AnyView(content())
    }
    return AnyView(EmptyView())
}
