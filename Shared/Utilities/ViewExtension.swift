//
//  ViewExtension.swift
//  natr
//
//  Created by Kris Reid on 05/08/2021.
//

import SwiftUI

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
