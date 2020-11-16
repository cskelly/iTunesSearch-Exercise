//
//  iTunesSearchApp.swift
//  iTunesSearch
//
//  Created by Cory Skelly on 11/15/20.
//

import SwiftUI

@main
struct iTunesSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(TrackViewModel())
        }
    }
}
