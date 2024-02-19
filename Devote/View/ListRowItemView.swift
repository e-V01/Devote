//
//  ListRowItemView.swift
//  Devote
//
//  Created by Y K on 19.02.2024.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item // (CRUD* - are the basic operator of persistent storage) create, read, update, delete
    
    var body: some View {
        Toggle(isOn: $item.completion, label: {
            Text(item.task ?? "")
                .font(.system(size: 22, weight: .heavy, design: .rounded))
                .foregroundStyle(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default, value: item.completion)
        })
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange, perform: { _ in // publisher
            if self.viewContext.hasChanges { // action (parameter)
                try? self.viewContext.save()
            }
        })
    }
}

//#Preview {
//    ListRowItemView()
//}
