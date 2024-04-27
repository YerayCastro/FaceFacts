//
//  PeopleView.swift
//  FaceFacts
//
//  Created by Yery Castro on 27/4/24.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    
    var body: some View {
        List {
            ForEach(people) { person in
                NavigationLink(value: person) {
                    Text(person.name)
                }
            }
            .onDelete(perform: deletePerson)
        }
    }
    
    init(searchingString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        _people = Query(filter: #Predicate { person in
            if searchingString.isEmpty {
                true
            } else {
                person.name.localizedStandardContains(searchingString) ||
                person.emailAddress.localizedStandardContains(searchingString) ||
                person.details.localizedStandardContains(searchingString)
            }
        }, sort: sortOrder)
    }
    
    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return PeopleView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
