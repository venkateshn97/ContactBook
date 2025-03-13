//
//  ContactDetailView.swift
//  ContactBook
//
//  Created by Venky on 3/13/25.
//

import SwiftUI

struct ContactDetailView: View {
    var contact: Contact
    @ObservedObject var viewModel: ContactViewModel
    @State private var isEditing = false

    var body: some View {
        VStack {
            Text(contact.emoji)
                .font(.system(size: 80))
            
            Text(contact.name)
                .font(.largeTitle)
                .bold()
            
            Text("📞 \(contact.phoneNumber)")
                .font(.title2)
            
            Text("✉️ \(contact.email)")
                .font(.title3)
                .foregroundColor(.gray)
            
            Button(action: {
                viewModel.toggleFavorite(for: contact)
            }) {
                HStack {
                    Image(systemName: contact.isFavorite ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                    Text(contact.isFavorite ? "Unfavorite" : "Mark Favorite")
                }
            }
            .padding()

            Spacer()
        }
        .toolbar {
            Button("Edit") {
                isEditing = true
            }
        }
        .sheet(isPresented: $isEditing) {
            AddEditContactView(viewModel: viewModel, contact: contact)
        }
    }
}

#Preview {
    ContactDetailView(contact: Contact(name: "John Doe", phoneNumber: "123-456-7890", email: "john@example.com", emoji: "😊"), viewModel: ContactViewModel())
}
