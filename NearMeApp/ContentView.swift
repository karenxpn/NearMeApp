//
//  ContentView.swift
//  NearMeApp
//
//  Created by Karen Mirakyan on 4/15/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var search: String = ""
    private var locationManager = LocationManager()
    @State private var landmarks = [Landmark]()
    @State private var tapped: Bool = false
    
    private func getNearbyLandmarks() {
        
        guard let location = self.locationManager.location else {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        request.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters:  1000, longitudinalMeters: 1000)
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response, error == nil else {
                return
            }
            
            let mapItems = response.mapItems
            self.landmarks = mapItems.map {
                Landmark(placemark: $0.placemark)
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        
        if landmarks.count > 0 && !self.tapped{
            return UIScreen.main.bounds.size.height -
                UIScreen.main.bounds.size.height / 4
        } else if self.tapped{
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        
        ZStack( alignment: .top) {
            MapView(landmarks: self.landmarks)
            
            TextField("Search", text: self.$search, onEditingChanged: { _ in }) {
                
                self.getNearbyLandmarks()
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
                .offset(y: 44)
            
            PlaceListView(landmards: landmarks) {
                self.tapped.toggle()
            }.animation(.spring())
            .offset(y: calculateOffset())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
