//
//  ContentView.swift
//  Devote
//
//  Created by Y K on 17.02.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROP
    @State var task: String = ""
    
    private var isButtonDisabled: Bool { //checks wehther textField isEmpty (Bool)
        task.isEmpty
    }
    // MARK: - FETCHING DATA (managed object context entirely in RAM)
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - Fetch request may have 4 parameters: entity, sort descriptor, predicate, animation
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default) // Prop (items)
    private var items: FetchedResults<Item>
    
    // MARK: - Func
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(spacing: 16)  {
                        TextField("New Task", text: $task)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Button {
                            addItem()
                        } label: {
                            Spacer()
                            Text("SAVE")
                            Spacer()
                        }
                        .disabled(isButtonDisabled)
                        .padding()
                        .font(.headline)
                        .foregroundStyle(.white)
                        .background(isButtonDisabled ? Color.gray : Color.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                    
                    List {
                        ForEach(items) { item in
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640) // will remove default vertical padding, and maximise list on iPad devices
                    .scrollContentBackground(.hidden)
                    .background(.clear)
                }
                
            }
//            .onAppear {
//                UITableView.appearance().backgroundColor = UIColor.clear
//            }
            
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .background(BackgroundImageView())
            .background(
                backgroundGradient.ignoresSafeArea(.all))
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        Text("Select an item")
    }
}







#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
