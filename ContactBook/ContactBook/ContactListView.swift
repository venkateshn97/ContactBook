//
//  ContentView.swift
//  ContactBook
//
//  Created by Venky on 3/13/25.
//

import SwiftUI

struct ContactListView: View {
    @StateObject private var viewModel = ContactViewModel()
    @State private var isAddingContact = false
    @State private var searchText = ""

    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return viewModel.contacts
        } else {
            return viewModel.contacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredContacts) { contact in
                    NavigationLink(destination: ContactDetailView(contact: contact, viewModel: viewModel)) {
                        HStack {
                            Text(contact.emoji)
                            VStack(alignment: .leading) {
                                Text(contact.name).font(.headline)
                                Text(contact.phoneNumber).font(.subheadline).foregroundColor(.gray)
                            }
                            Spacer()
                            if contact.isFavorite {
                                Image(systemName: "star.fill").foregroundColor(.yellow)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteContact)
            }
            .searchable(text: $searchText)
            .navigationTitle("Contacts")
            .toolbar {
                Button(action: { isAddingContact = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddingContact) {
                AddEditContactView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContactListView()
}
