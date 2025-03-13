//
//  EmojiPickerView.swift
//  ContactBook
//
//  Created by Venky on 3/13/25.
//

import SwiftUI

struct EmojiPickerView: View {
    @Binding var selectedEmoji: String
    let emojis = ["😀", "😎", "🎉", "❤️", "📞", "💻"]

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .font(.largeTitle)
                        .padding()
                        .onTapGesture {
                            selectedEmoji = emoji
                        }
                }
            }
        }
    }
}
#Preview {
    @Previewable @State var emoji: String = "😀"
    return EmojiPickerView(selectedEmoji: $emoji)
}

