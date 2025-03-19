import CoreMotion
import SwiftUI

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private var timer: Timer?
    private var onShake: (() -> Void)?
    
    // Threshold for shake detection
    private let shakeThreshold: Double = 2.0
    
    func startMonitoringShake(completion: @escaping () -> Void) {
        guard motionManager.isAccelerometerAvailable else {
            print("Accelerometer not available")
            return
        }
        
        onShake = completion
        motionManager.accelerometerUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            guard let self = self, let data = data else { return }
            
            let acceleration = data.acceleration
            let accelerationValue = sqrt(
                pow(acceleration.x, 2) +
                pow(acceleration.y, 2) +
                pow(acceleration.z, 2)
            ) - 1.0  // Subtract gravity
            
            if accelerationValue >= self.shakeThreshold {
                self.onShake?()
                
                // Disable further shake detection for a short period
                self.stopMonitoringShake()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.startMonitoringShake(completion: completion)
                }
            }
        }
    }
    
    func stopMonitoringShake() {
        motionManager.stopAccelerometerUpdates()
    }
} 