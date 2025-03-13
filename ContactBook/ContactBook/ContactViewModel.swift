//
//  ContactViewModel.swift
//  ContactBook
//
//  Created by Venky on 3/13/25.
//

import SwiftUI

class ContactViewModel: ObservableObject {
    @Published var contacts: [Contact] = [] {
        didSet {
            saveContacts()
        }
    }
    
    let userDefaultsKey = "savedContacts"

    init() {
        loadContacts()
    }
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
    }
    
    func updateContact(_ contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index] = contact
        }
    }
    
    func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
    
    func toggleFavorite(for contact: Contact) {
        if let index = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[index].isFavorite.toggle()
        }
    }
    
    private func saveContacts() {
        if let encoded = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadContacts() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([Contact].self, from: savedData) {
            contacts = decoded
        }
    }
}
