//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Yery Castro on 27/4/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person: Person
    @Binding var navigationPath: NavigationPath
    @State private var selectedItem: PhotosPickerItem?
    
    @Query(sort: [
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]
    
    var body: some View {
        Form {
            Section {
                if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email Addres", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            } header: {
                Text("Personal Data")
            }
            
            Section {
                Picker("Meet at", selection: $person.metAt) {
                    Text("Unknown")
                        .tag(Optional<Event>.none)
                    
                    if events.isEmpty == false {
                        Divider()
                        
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }
                
                Button {
                    addEvent()
                } label: {
                    Text("Add a new event")
                }
            } header: {
                Text("Where did you meet them?")
            }
            
            Section {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            } header: {
                Text("Notes")
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
        .onChange(of: selectedItem, loadPhoto)
    }
    
    func addEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
        navigationPath.append(event)
    }
    
    func loadPhoto() {
        Task { @MainActor in
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}


#Preview {
    do {
        let previewer = try Previewer()

        return EditPersonView(person: previewer.person, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
