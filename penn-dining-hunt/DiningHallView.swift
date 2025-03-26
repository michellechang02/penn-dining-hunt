import SwiftUI
import CoreLocation

struct DiningHallView: View {
    var diningHall: DiningHall
    @EnvironmentObject var diningHallViewModel: DiningHallViewModel
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var motionManager: MotionManager
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var scribblePoints: [CGPoint] = []
    @State private var isCollecting = false
    
    var body: some View {
        VStack {
            Image(diningHall.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .cornerRadius(12)
                .padding()
            
            Text(diningHall.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text(diningHall.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // Status message
            Group {
                if diningHallViewModel.isCollected(diningHall) {
                    Text("You've already collected this dining hall!")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .padding()
                } else if !isNearDiningHall() {
                    Text("You need to be within 50 meters to collect this dining hall")
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                        .padding()
                } else {
                    Text("Shake your phone to collect this dining hall!")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                        .padding()
                    
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Dining Hall Details")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Collection Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            // Start monitoring for shake when view appears
            motionManager.startMonitoringShake {
                attemptCollection()
            }
        }
        .onDisappear {
            // Stop monitoring for shake when view disappears
            motionManager.stopMonitoringShake()
        }
    }
    
    private func isNearDiningHall() -> Bool {
        guard let userLocation = locationManager.userLocation else {
            return false
        }
        
        let diningHallLocation = CLLocation(
            latitude: diningHall.latitude, 
            longitude: diningHall.longitude
        )
        
        let distance = userLocation.distance(from: diningHallLocation)
        return distance <= 50 // 50 meters
    }
    
    private func attemptCollection() {
        // Prevent multiple collection attempts
        guard !isCollecting else { return }
        isCollecting = true
        
        // Check if already collected
        if diningHallViewModel.isCollected(diningHall) {
            alertMessage = "You've already collected this dining hall!"
            showAlert = true
            isCollecting = false
            return
        }
        
        // Check if near dining hall
        if !isNearDiningHall() {
            alertMessage = "You need to be within 50 meters of the dining hall to collect it."
            showAlert = true
            isCollecting = false
            return
        }
        
        // Collect the dining hall
        diningHallViewModel.collectDiningHall(diningHall)
        alertMessage = "Congratulations! You've collected \(diningHall.name)!"
        showAlert = true
        isCollecting = false
    }
    
} 
