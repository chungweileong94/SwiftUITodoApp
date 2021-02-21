//
//  CheckBox.swift
//  SwiftUITodoApp
//
//  Created by White Room 02 on 20/02/2021.
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

struct CheckBox<Label>: View where Label: View {
    @Binding var isChecked: Bool
    let label: Label

    init(isChecked: Binding<Bool>, @ViewBuilder label: () -> Label) {
        self._isChecked = isChecked
        self.label = label()
    }

    func toggle() {
        isChecked.toggle()
    }

    var body: some View {
        Toggle(isOn: $isChecked) {
            label
        }
        .toggleStyle(CustomToggleStyle())
    }
}

#if DEBUG
struct CheckBox_PreviewsController: View {
    @State var isChecked: Bool

    var body: some View {
        CheckBox(isChecked: $isChecked) {
            Text("Label")
                .font(.title)
        }
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
