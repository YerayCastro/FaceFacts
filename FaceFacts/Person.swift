//
//  Person.swift
//  FaceFacts
//
//  Created by Yery Castro on 27/4/24.
//

import Foundation
import SwiftData

@Model
final class Person {
    var name: String
    var emailAddress: String
    var details: String
    var metAt: Event?
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, emailAddress: String, details: String, metAt: Event? = nil) {
        self.name = name
        self.emailAddress = emailAddress
        self.details = details
        self.metAt = metAt
    }
}
