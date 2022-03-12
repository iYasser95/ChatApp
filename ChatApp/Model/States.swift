//
//  States.swift
//  ChatApp
//
//  Created by Apple on 09/03/2022.
//

import Foundation
enum States: Hashable, Identifiable {
    var id: States { self }
    case profile
    case logout
}
