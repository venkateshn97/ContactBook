//
//  AddContactView.swift
//  ContactBook
//
//  Created by Venky on 3/13/25.
//

import SwiftUI

struct AddEditContactView: View {
    @ObservedObject var viewModel: ContactViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var emoji = "😀"
    
    var contact: Contact?

    init(viewModel: ContactViewModel, contact: Contact? = nil) {
        self.viewModel = viewModel
        if let contact = contact {
            _name = State(initialValue: contact.name)
            _phoneNumber = State(initialValue: contact.phoneNumber)
            _email = State(initialValue: contact.email)
            _emoji = State(initialValue: contact.emoji)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Name", text: $name)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    EmojiPickerView(selectedEmoji: $emoji)
                }
            }
            .navigationTitle(contact == nil ? "Add Contact" : "Edit Contact")
            .toolbar {
                Button("Save") {
                    let newContact = Contact(id: contact?.id ?? UUID(), name: name, phoneNumber: phoneNumber, email: email, emoji: emoji)
                    if contact == nil {
                        viewModel.addContact(newContact)
                    } else {
                        viewModel.updateContact(newContact)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    AddEditContactView(viewModel: ContactViewModel())
}
