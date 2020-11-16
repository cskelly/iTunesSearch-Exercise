//
//  TrackCellView.swift
//  iTunesSearch
//
//  Created by Cory Skelly on 11/16/20.
//

import SwiftUI

struct TrackCellView : View {
    let track: Track
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(track.trackName).bold()
                    Text(track.artistName)
                    Text(track.primaryGenreName)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$\(track.trackPrice)")
                    Text(track.releaseDate)
                }
            }.padding(20)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static let previewTrack = Track(id: 1,
                                    artistName: "Pink Floyd",
                                    trackName: "Comfortably Numb",
                                    releaseDate: "11-12-13",
                                    trackPrice: "1.29",
                                    primaryGenreName: "Rock")
    
    static var previews: some View {
        TrackCellView(track: previewTrack)
    }
}
