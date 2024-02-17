//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Y K on 17.02.2024.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true) // keeps ration of image smotthly when it gets smaller or bigger
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
