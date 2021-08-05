//
//  Contact.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI
import Contacts

struct ContactInfo : Identifiable, Hashable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var phoneNumber: CNPhoneNumber?
    var mobileNumber: String
}
