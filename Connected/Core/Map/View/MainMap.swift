import SwiftUI
import FirebaseAuth
import MapKit
import CoreLocation

struct MainMap: View {
    @StateObject private var firestoreManager = FirestoreManager()
    @StateObject private var locationManager = LocationManager()
    
    @State private var showProfileDetail = false
    @State private var selectedUser: User?
    @State private var didSetInitialCameraPosition = false

    @State private var cameraPosition: MapCameraPosition = .automatic
    

    
    var body: some View {
        Map(position: $cameraPosition, interactionModes: .all) {
            ForEach(firestoreManager.usersLoc.filter { $0.id != firestoreManager.currentUserId }) { user in
                if let latitude = user.latitude, let longitude = user.longitude {
                    Annotation("", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                        CustomMarker(user: user) {
                            selectedUser = user
                            showProfileDetail = true
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
        }
        .navigationDestination(isPresented: $showProfileDetail) {
            if let selectedUser = selectedUser {
                ProfileDetail(user: selectedUser)
                    .accentColor(.brand)
            }
        }
        .onAppear {
            if let userId = Auth.auth().currentUser?.uid {
                firestoreManager.currentUserId = userId
            }
            firestoreManager.fetchUserLocations()
        }
        .onChange(of: locationManager.location) { newLocation in
            if let location = newLocation {
                updateUserLocationAndFetch(location: location)
                cameraPosition = .camera(MapCamera(centerCoordinate: location.coordinate, distance: 1000))

            }
        }
    }
    
    private func updateUserLocationAndFetch(location: CLLocation) {
        guard let userId = firestoreManager.currentUserId else { return }
        firestoreManager.updateUserLocation(userId: userId, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { success in
            if success {
                print("User location updated successfully")
                firestoreManager.fetchUserLocations()
            } else {
                print("Failed to update user location")
            }
        }
    }
}

#Preview {
    MainMap()
}
