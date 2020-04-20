//
//  PlaceListView.swift
//  NearMeApp
//
//  Created by Karen Mirakyan on 4/20/20.
//  Copyright © 2020 Karen Mirakyan. All rights reserved.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmards: [Landmark]
    var onTap: () -> ()
    
    var body: some View {
        
        VStack {
            
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.blue)
                .gesture(TapGesture()
                    .onEnded(self.onTap))
            
            
            List {
                ForEach( self.landmards, id: \.id ) { landmark in
                    Text( landmark.name )
                }.animation(nil)
            }
        }.cornerRadius(16)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmards: [Landmark(placemark: MKPlacemark())], onTap: {})
    }
}
