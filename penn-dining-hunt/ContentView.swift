// ContentView.swift
// penn-dining-hunt
//
// Created by Michelle Chang on 3/14/25.
//

import SwiftUI
import CoreLocation
import Foundation

// Remove the ViewModel class from here since it seems to be defined elsewhere
// class DiningHallViewModel: ObservableObject { ... }

struct ContentView: View {
    @EnvironmentObject var diningHallViewModel: DiningHallViewModel  // Use EnvironmentObject for shared state

    var body: some View {
        NavigationStack {
            List {
                ForEach(diningHallViewModel.diningHalls) { (diningHall: DiningHall) in
                    NavigationLink(destination: DiningHallView(diningHall: diningHall)) {
                        HStack {
                            Image(diningHall.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            VStack(alignment: .leading) {
                                Text(diningHall.name)
                                    .font(.headline)
                                Text(diningHall.description)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            
                            Spacer()
                            
                            if diningHallViewModel.isCollected(diningHall) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                                    .font(.title2)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Penn Dining Hunt")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Collected: \(diningHallViewModel.progress())")
                        .font(.subheadline)
                        .padding(6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
    }
}

// PreviewProvider for SwiftUI Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DiningHallViewModel()) // Inject EnvironmentObject
    }
}

// MARK: - ViewModel
class DiningHallViewModel: ObservableObject {
    @Published var diningHalls: [DiningHall] = []
    @Published var collectedDiningHalls: Set<String> = []
    
    init() {
        // Initialize with sample data for preview
        loadDiningHalls()
    }
    
    private func loadDiningHalls() {
        // Sample dining halls with coordinates
        diningHalls = [
            DiningHall(id: "1", name: "1920 Commons", description: "Main campus dining hall", image: "commons", latitude: 39.9510, longitude: -75.1989),
            DiningHall(id: "2", name: "Accenture Café", description: "Café in Huntsman Hall", image: "accenture", latitude: 39.9526, longitude: -75.1984),
            DiningHall(id: "3", name: "Falk Kosher Dining", description: "Kosher dining options", image: "falk", latitude: 39.9523, longitude: -75.2026),
            DiningHall(id: "4", name: "Hill House", description: "Traditional dining hall", image: "hill", latitude: 39.9531, longitude: -75.1918),
            DiningHall(id: "5", name: "Houston Market", description: "Food court style dining", image: "houston", latitude: 39.9505, longitude: -75.1938),
            DiningHall(id: "6", name: "Joe's Café", description: "Casual café", image: "joes", latitude: 39.9532, longitude: -75.1951),
            DiningHall(id: "7", name: "Kings Court English House", description: "Residential dining hall", image: "kings", latitude: 39.9554, longitude: -75.1926),
            DiningHall(id: "8", name: "Lauder College House", description: "Modern dining options", image: "lauder", latitude: 39.9543, longitude: -75.2018),
            DiningHall(id: "9", name: "McClelland Express", description: "Quick dining option", image: "mcclelland", latitude: 39.9507, longitude: -75.1968),
            DiningHall(id: "10", name: "Pret A Manger", description: "Grab and go options", image: "pret", latitude: 39.9528, longitude: -75.1969),
            DiningHall(id: "11", name: "Quaker Kitchen", description: "Community dining space", image: "quaker", latitude: 39.9521, longitude: -75.1980)
        ]
    }
    
    func isCollected(_ diningHall: DiningHall) -> Bool {
        return collectedDiningHalls.contains(diningHall.id)
    }
    
    func collectDiningHall(_ diningHall: DiningHall) {
        collectedDiningHalls.insert(diningHall.id)
    }
    
    func progress() -> String {
        return "\(collectedDiningHalls.count)/\(diningHalls.count)"
    }
}


