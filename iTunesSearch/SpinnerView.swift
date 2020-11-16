//
//  SpinnerView.swift
//  iTunesSearch
//
//  Created by Cory Skelly on 11/16/20.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
    }
}
