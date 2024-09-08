//
//  ForecastBottomScreen.swift
//  Weather
//
//  Created by Harsh Pranay on 13/08/24.
//

import SwiftUI

struct ForecastBottomScreen: View {

    @State private var isSheetPresented: Bool = false

    var body: some View {
        ZStack {
            VStack {
                Button("Show Custom Bottom Sheet") {
                    isSheetPresented.toggle()
                }
            }

            if isSheetPresented {
                BottomSheetView(
                    isPresented: $isSheetPresented,
                    height: nil, // Optional, will use content height if nil
                    shouldAnimate: true, // Optional, default is true
                    animationDuration: 0.5, // Optional, default is 0.3
                    cornerRadius: 20, // Optional, default is 16
                    isScrollable: true, // Optional, default is false
                    content: {
                        VStack {
                            Text("This is a custom bottom sheet with optional parameters")
                                .font(.headline)
                                .padding()

                            Button("Dismiss") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isSheetPresented = false
                                }
                            }
                        }
                        .padding()
                    }
                )
                .onTapGesture {
                    isSheetPresented = false // Close on tap outside
                }
            }
        }
    }
}

#Preview {
    ForecastBottomScreen()
}
