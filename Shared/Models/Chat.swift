//
//  Chat.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import Foundation

struct Chat: Codable, Hashable {
    var reciever: User
    var groupId: String
    var lastMessage: String
}
