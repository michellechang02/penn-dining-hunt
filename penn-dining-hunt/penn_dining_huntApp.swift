//
//  penn_dining_huntApp.swift
//  penn-dining-hunt
//
//  Created by Michelle Chang on 3/14/25.
//

import SwiftUI
import CoreLocation

@main
struct penn_dining_huntApp: App {
    @State private var diningHallViewModel = DiningHallViewModel()
    @State private var locationManager = LocationManager()
    @State private var motionManager = MotionManager()
    
    init() {
        // Add location usage descriptions to Info.plist
        if let _ = Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") as? String {
            // Description already exists
        } else {
            print("Warning: Add 'NSLocationWhenInUseUsageDescription' to Info.plist")
            print("Add: 'We need your location to verify when you're near dining halls'")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(diningHallViewModel)
                .environmentObject(locationManager)
                .environmentObject(motionManager)
        }
    }
}
