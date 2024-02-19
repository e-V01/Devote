//
//  BlankView.swift
//  Devote
//
//  Created by Y K on 19.02.2024.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        VStack {
            Spacer()
                
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
        .background(Color.black)
        .opacity(0.5)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    BlankView()
}
