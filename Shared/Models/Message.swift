//
//  Message.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message : Identifiable, Codable, Hashable {
    var id: String
    var content: String
    var userId: String
    var timeDate: Timestamp
}
