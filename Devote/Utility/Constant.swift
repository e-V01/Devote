//
//  Constant.swift
//  Devote
//
//  Created by Y K on 17.02.2024.
//

import SwiftUI
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//UI
var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]),
                          startPoint: .topLeading, endPoint: .bottomTrailing)
}

// UX

let feedback = UINotificationFeedbackGenerator()
