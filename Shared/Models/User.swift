//
//  User.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import CryptoKit


struct User: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var mobileNumber: String
    var imageUrl: String
    var fcmToken: String
    var publicToken: String
    var groups: [String]
    var favourites: [String]

    init(id: String, name: String, mobileNumber: String, imageUrl: String, fcmToken: String, publicToken: String, groups: [String], favourites: [String]) {
        self.id = id
        self.name = name
        self.mobileNumber = mobileNumber
        self.imageUrl = imageUrl
        self.fcmToken = fcmToken
        self.publicToken = publicToken
        self.groups = groups
        self.favourites = favourites
    }
}


struct Group: Codable, Hashable {
    var id: String
    var createdBy: String
    var members: [String]
    var createdOn: Date
    var lastMessage: String
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: createdOn)
    }
}
