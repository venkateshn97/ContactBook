//
//  Contact.swift
//  ContactBook
//
//  Created by Venky on 3/13/25.
//

import Foundation

struct Contact: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var phoneNumber: String
    var email: String
    var isFavorite: Bool = false
    var emoji: String
}
