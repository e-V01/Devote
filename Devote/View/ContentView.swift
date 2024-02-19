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
    @AppStorage ("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    // MARK: - FETCHING DATA (managed object context entirely in RAM)
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - Fetch request may have 4 parameters: entity, sort descriptor, predicate, animation
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default) // Prop (items)
    private var items: FetchedResults<Item>
    
    // MARK: - Func
    
    
    
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
                // Main View
                VStack {
                    // HEADER
                    HStack(spacing: 10) {
                        // TITLE
                         Text("Devote")
                            .font(.system(size: 30, weight: .heavy, design: .rounded))
                            .padding(.leading, 4)
                        
                        Spacer()
                        // EDIT
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                        // APPEARANCE
                        Button {
                            // toggle appearance
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                        } label: {
                            Image(systemName: 
                                    isDarkMode ?  "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(size: 20, design: .rounded))
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    Spacer(minLength: 35)
                    // New  TASK BUTTON
                    Button {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(Capsule()))
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    //TASKS
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
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
                .blur(radius: showNewTaskItem ? 8 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                if showNewTaskItem {
                    BlankView(backgroundColor: isDarkMode ?  Color.black : Color.gray,
                              backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
//            .onAppear {
//                UITableView.appearance().backgroundColor = UIColor.clear
//            }
            
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarHidden(true)
            .background(BackgroundImageView()
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
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
