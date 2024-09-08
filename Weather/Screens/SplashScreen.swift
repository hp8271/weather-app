//
//  SplashScreen.swift
//  Weather
//
//  Created by Harsh Pranay on 12/08/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                // Navigate to the main view after splash screen
                HomeView()
            } else {
                // Splash screen content
                ZStack {
                    BlurryMountainView() {
                        VStack {
                            Text("Showing Weather\n In No Time...")
                                .font(.system(size: 30))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            LineProgressView(secondsToComplete: 2) {
                                self.isActive = true
                            }
                            .frame(width: MobileBounds.width * 0.75, alignment: .center)
                        }

                    }

                }

            }
        }
        //        .onAppear {
        //            // Delay for the splash screen
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 3000) {
        //                withAnimation {
        //                    self.isActive = true
        //                }
        //            }
        //        }
    }
}

//struct SplashScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashScreenView()
//    }
//}


#Preview {
    SplashScreenView()
}
