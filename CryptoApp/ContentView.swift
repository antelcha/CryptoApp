//
//  ContentView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 13.03.2023.
//

import SwiftUI

import SwiftUI
import SwiftUI

struct ContentView: View {
    @State private var selectedText: String = ""

    var body: some View {
        TextEditor(text: $selectedText)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { _ in
                guard let selectedRange = UIApplication.shared.windows.first?.rootViewController?.view.viewWithTag(1)?.textInput?.selectedTextRange,
                      let textView = UIApplication.shared.windows.first?.rootViewController?.view.viewWithTag(1) as? UITextView
                else { return }

                if let selectedText = textView.text(in: selectedRange) {
                    let trimmedText = selectedText.trimmingCharacters(in: .whitespacesAndNewlines)
                    print(trimmedText)
                }
            }
            .tag(1)
            .frame(width: 300, height: 300)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

