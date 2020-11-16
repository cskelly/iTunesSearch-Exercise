//
//  Track.swift
//  iTunesSearch
//
//  Created by Cory Skelly on 11/15/20.
//

import Foundation

struct Track: Identifiable {
    let id: Int
    let artistName: String
    let trackName: String
    let releaseDate: String
    let trackPrice: String
    let primaryGenreName: String
}
