//
//  TrackViewModelTests.swift
//  iTunesSearchTests
//
//  Created by Cory Skelly on 11/16/20.
//

import XCTest

class TrackViewModelTests: XCTestCase {
    var viewModel = TrackViewModel()
    
    var sut: URLSession!

    override func setUp() {
      super.setUp()
      sut = URLSession(configuration: .default)
    }

    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    func testSearchForTracks() throws {
            
        // Invalid Input (Empty)
        viewModel.searchForTracks(queryString: "")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid artist name")
        XCTAssertTrue(viewModel.tracks.isEmpty)
        
        // Invalid Input characterse
        viewModel.searchForTracks(queryString: "Test String #")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid artist name")
        XCTAssertTrue(viewModel.tracks.isEmpty)
    }
    
    func testIsValidQuery() throws {
        // Valid Query String
        var queryString = "Metallica"
        XCTAssertTrue(viewModel.isValidQuery(queryString))
        
        // Empty Query String
        queryString = ""
        XCTAssertFalse(viewModel.isValidQuery(queryString))

        // Query with special characters
        queryString = "Test #@)^("
        XCTAssertFalse(viewModel.isValidQuery(queryString))
    }
    
    func testFormatDateString() throws {
        // Valid date string
        var dateString = "2020-11-15T10:30:22Z"
        XCTAssertEqual(viewModel.formatDateString(dateString), "Nov 15, 2020")
        
        // Invalid date String
        dateString = "11-15-2020"
        XCTAssertEqual(viewModel.formatDateString(dateString), "")
    }
}
