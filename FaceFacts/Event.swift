//
//  Event.swift
//  FaceFacts
//
//  Created by Yery Castro on 27/4/24.
//

import Foundation
import SwiftData


@Model
final class Event {
    var name: String
    var location: String
    var people = [Person]()
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
