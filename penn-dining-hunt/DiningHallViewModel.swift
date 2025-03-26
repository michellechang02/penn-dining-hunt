//
//  DiningHallViewModel.swift
//  penn-dining-hunt
//
//  Created by Olivia Li on 3/25/25.
//
import SwiftUI
import CoreLocation

class DiningHallViewModel: ObservableObject {
    @Published var diningHalls: [DiningHall] = []
    @Published var collectedDiningHalls: Set<String> = []
    
    init() {
        loadDiningHalls()
    }
    
    private func loadDiningHalls() {
        diningHalls = [
            DiningHall(id: "1", name: "1920 Commons", description: "Main campus dining hall", image: "commons", latitude: 39.95248, longitude: -75.19938),
            DiningHall(id: "2", name: "Accenture Café", description: "Café in Towne Building", image: "accenture", latitude: 39.95202, longitude: -75.19135),
            DiningHall(id: "3", name: "Falk Kosher Dining", description: "Kosher dining options", image: "falk", latitude: 39.95314, longitude: -75.20015),
            DiningHall(id: "4", name: "Hill House", description: "Traditional dining hall", image: "hill", latitude: 39.95300, longitude: -75.19071),
            DiningHall(id: "5", name: "Houston Market", description: "Food court style dining", image: "houston", latitude: 39.95091, longitude: -75.19388),
            DiningHall(id: "6", name: "Joe's Café", description: "Casual café", image: "joes", latitude: 39.95156, longitude: -75.19652),
            DiningHall(id: "7", name: "Kings Court English House", description: "Residential dining hall", image: "kings", latitude: 39.95416, longitude: -75.19418),
            DiningHall(id: "8", name: "Lauder College House", description: "Modern dining options", image: "lauder", latitude: 39.95382, longitude: -75.19108),
            DiningHall(id: "9", name: "McClelland Express", description: "Quick dining option", image: "mcclelland", latitude: 39.95107, longitude: -75.19839),
            DiningHall(id: "10", name: "Pret A Manger", description: "Grab and go options", image: "pret", latitude: 39.95263, longitude: -75.19848),
            DiningHall(id: "11", name: "Quaker Kitchen", description: "Community dining space", image: "quaker", latitude: 39.95354, longitude: -75.20198)
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
