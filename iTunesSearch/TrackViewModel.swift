//
//  TrackViewModel.swift
//  iTunesSearch
//
//  Created by Cory Skelly on 11/16/20.
//

import Foundation
import SwiftUI

class TrackViewModel: ObservableObject {
    @Published var tracks = [Track]()
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    
    func searchForTracks(queryString: String) {
        guard isValidQuery(queryString) else {
            self.isLoading = false
            self.errorMessage = "Please enter a valid artist name"
            self.tracks = []
            return
        }
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: queryString)
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        isLoading = true
        errorMessage = ""
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var resultTracks = [Track]()
            if let response = response as? HTTPURLResponse,
               response.statusCode == 200,
               let data = data {
                resultTracks = self.processTracks(data)
            }
            
            sleep(1) // This sleep is just to allow the background thread to take a moment longer so the spinner can be more visible.

            DispatchQueue.main.async {
                self.isLoading = false
                self.tracks = resultTracks
                
                if let error = error {
                    self.errorMessage += "Network Error: \(error.localizedDescription)\n"
                }
            }
        }

        task.resume()
    }
    
    // Processes the data from the rest cal into track data.
    private func processTracks(_ results: Data) -> [Track] {
        //Take the data, parse it and build our Tracks.
        var response: [String: Any]?
        var resultTracks = [Track]()
        
        do {
          response = try JSONSerialization.jsonObject(with: results, options: []) as? [String: Any]
        } catch let parseError as NSError {
          errorMessage += "Error parsing Json: \(parseError.localizedDescription)\n"
          return []
        }
        
        guard let array = response!["results"] as? [Any] else {
          errorMessage += "Result Error: Dictionary does not contain results key\n"
          return []
        }
        
        for trackDictionary in array {
          if let trackDictionary = trackDictionary as? [String: Any],
            let id = trackDictionary["trackId"] as? Int,
            let artistName = trackDictionary["artistName"] as? String,
            let trackName = trackDictionary["trackName"] as? String,
            let releaseDate = trackDictionary["releaseDate"] as? String,
            let trackPrice = trackDictionary["trackPrice"] as? Double,
            let primaryGenreName = trackDictionary["primaryGenreName"] as? String {
            
            resultTracks.append(Track(id: id,
                                      artistName: artistName,
                                      trackName: trackName,
                                      releaseDate: formatDateString(releaseDate),
                                      trackPrice: trackPrice.toString(),
                                      primaryGenreName: primaryGenreName))
          } else {
            errorMessage += "Error: result missing fields\n"
          }
        }
        
        return resultTracks
    }
    
    
    // Checks that the string is not empty and doesn't have special characters
    func isValidQuery(_ queryString: String) -> Bool {
        guard !queryString.isEmpty else {
            return false
        }
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z\\s].*", options: .caseInsensitive)
        return regex.firstMatch(in: queryString, options: .anchored, range: NSMakeRange(0, queryString.count)) == nil
    }
    
    // Formats date to a more readable string
    func formatDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
}
