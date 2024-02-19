//
//  BlankView.swift
//  Devote
//
//  Created by Y K on 19.02.2024.
//

import SwiftUI

struct BlankView: View {
    var backgroundColor: Color
    var backgroundOpacity: Double
    var body: some View {
        VStack {
            Spacer()
                
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3)
        .background(BackgroundImageView())
        .background(backgroundGradient.ignoresSafeArea(.all))
}
