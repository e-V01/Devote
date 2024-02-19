//
//  CheckBoxStyle.swift
//  Devote
//
//  Created by Y K on 19.02.2024.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            configuration.label
        }
    }
}

#Preview {
    Toggle("Placeholder label", isOn: .constant(false))
        .toggleStyle(CheckBoxStyle())
        .previewLayout(.sizeThatFits)
}
