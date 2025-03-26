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
    @State private var showLocationPermissionAlert = true
    @Environment(\.scenePhase) private var scenePhase
    
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
            ZStack {
                ContentView()
                    .environmentObject(diningHallViewModel)
                    .environmentObject(locationManager)
                    .environmentObject(motionManager)
                    .onReceive(locationManager.$authorizationStatus) { status in
                        if status == .denied || status == .restricted {
                            // Exit the app if permissions denied
                            exit(0)
                        }
                    }
                
                // Location permission alert
                if showLocationPermissionAlert {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {} // Prevent tap through
                    
                    VStack {
                        Text("Location Permission Required")
                            .font(.headline)
                            .padding(.bottom, 10)
                        
                        Text("This app needs your location to check whether you are near Penn dining halls and to determine if they have been collected. Without location access, we can not check for dining hallsproperly.")
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        
                        HStack(spacing: 20) {
                            Button("Exit App") {
                                exit(0)
                            }
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            
                            Button("Allow") {
                                showLocationPermissionAlert = false
                                locationManager.requestLocationPermission()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding(40)
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                // Check if permission is already denied when app becomes active
                if locationManager.authorizationStatus == .denied || 
                   locationManager.authorizationStatus == .restricted {
                    exit(0)
                }
            }
        }
    }
}
