//
//  Previewer.swift
//  FaceFacts
//
//  Created by Yery Castro on 27/4/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)
        
        event = Event(name: "Dimension Jump", location: "Nottingham")
        person = Person(name: "Dave Liester", emailAddress: "dave@reddwarf.com", details: "", metAt: event)
        
        container.mainContext.insert(person)
    }
}
