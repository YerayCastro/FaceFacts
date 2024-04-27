//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Yery Castro on 27/4/24.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
