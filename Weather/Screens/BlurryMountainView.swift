//
//  BlurryMountainView.swift
//  Weather
//
//  Created by Harsh Pranay on 13/08/24.
//

import SwiftUI

struct BlurryMountainView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        ZStack {
            // The main content of the parent view
            Image(ImagesValue.starryMountain.rawValue)
                .resizable() // Makes the image resizable
                .scaledToFill() // Scales the image to fill the screen
                .edgesIgnoringSafeArea(.all)
            
            // The dynamically passed subview
            content()
        }
    }
}

#Preview {
    BlurryMountainView() {
        Text("Hello world ")
            .padding()
    }
}
