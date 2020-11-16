//
//  ContentView.swift
//  iTunesSearch
//
//  Created by Cory Skelly on 11/15/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TrackViewModel
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    HStack {
                        TextField("", text: $text)
                            .padding(10)
                            .frame(height: 42)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        Button(action: {
                            !viewModel.isLoading ? self.viewModel.searchForTracks(queryString: text) : nil
                        } ) {
                            Text("Search Artist")
                        }
                    }
                    .padding([.leading, .trailing], 16)
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .padding(5)
                            .foregroundColor(.red)
                    }
                    
                    if viewModel.isLoading {
                        ZStack {
                            Color(.systemGray6)
                            .edgesIgnoringSafeArea(.all)
                            ActivityIndicator()
                        }
                    } else {
                        List(viewModel.tracks) { track in
                            TrackCellView(track: track)
                        }
                    }
                }.navigationBarTitle("iTunes Artist Search")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
