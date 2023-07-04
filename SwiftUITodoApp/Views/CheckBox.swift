//
//  CheckBox.swift
//  SwiftUITodoApp
//
//  Created by Chung Wei Leong on 20/02/2021.
//

import SwiftUI

private struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 24))
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

struct CheckBox: View {
    @Binding var isChecked: Bool

    init(isChecked: Binding<Bool>) {
        _isChecked = isChecked
    }

    func toggle() {
        isChecked.toggle()
    }

    var body: some View {
        Toggle(isOn: $isChecked) {}
            .toggleStyle(CustomToggleStyle())
    }
}

#if DEBUG
    struct CheckBox_PreviewsController: View {
        @State var isChecked: Bool

        var body: some View {
            CheckBox(isChecked: $isChecked)
                .padding()
        }
    }

    struct CheckBox_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                CheckBox_PreviewsController(isChecked: true)
                    .previewLayout(.sizeThatFits)
                    .previewDisplayName("Checked")
                CheckBox_PreviewsController(isChecked: false)
                    .previewLayout(.sizeThatFits)
                    .previewDisplayName("Unchecked")
            }
        }
    }
#endif
