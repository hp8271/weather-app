//
//  BottomSheeetView.swift
//  Weather
//
//  Created by Harsh Pranay on 17/08/24.
//

import SwiftUI

struct BottomSheeetView<Content: View>: View {
    var isScrollable: Bool = false
    var content: () -> Content

    @State private var contentHeight: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            Spacer() // Push content to the bottom

            ZStack {
                VStack {
                    RoundedTopCornersShape(cornerRadius: 16)
                        .fill(Color.white) // Fill the shape with your desired color
                        .frame(height: 49) // Adjust height as needed
                        .overlay(
                            RoundedTopCornersShape(cornerRadius: 16)
                                .stroke(Color.black, lineWidth: 1) // Optional border for visibility
                        )
                }
                .background(Color.white.opacity(0.2)) // Background to show contrast
                VStack{
                    RoundedRectangle(cornerRadius: 48)
                        .fill(Color.black.opacity(0.5))
                        .frame(width: 48 , height: 5)
                        .offset(y: 0)
                    HStack {
                        Text("Hourly Forecast")
                            .padding(.leading, 32)
                            .foregroundColor(Color(hex: "#A9A9A9"))
                            .fontWeight(.medium)

                        Spacer()
                        Text("Weekly Forecast")
                            .foregroundColor(Color(hex: "#A9A9A9"))
                            .padding(.trailing, 32)
                            .fontWeight(.medium)
                    }
                }
            }

            if isScrollable {
                ScrollView {
                    customView(content: content)
                }
                .frame(height: contentHeight)
                .background(Color.white)
            }
            else {
                customView(content: content)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Full screen width and height
        .background(Color(hex: "#D3D3D4"))
    }

    func customView(content: @escaping () -> Content) -> some View {
        content()
            .background(GeometryReader { geo in
                Color.white
                    .onAppear {
                        contentHeight = geo.size.height
                    }
            })
            .frame(maxWidth: .infinity)
            .background(Color.white)
    }
}

#Preview {
    
    BottomSheeetView( isScrollable: false, content: {
        VStack(content: {

            VStack {
                Spacer() // Pushes the content to the bottom

                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(0..<10) { _ in
                            HourlyView(time: "12 PM", image: .tornado, temp: "30", percentage: 30, isSelected: false)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                }
                .cornerRadius(10) // Optional: Add corner radius
//                .background(GeometryReader { geo in
//                    Color.clear
//                        .onAppear {
//                            scrollViewHeight = geo.size.height
//                        }
//                        .onChange(of: geo.size.height) { newValue in
//                            scrollViewHeight = newValue
//                        }
//                })
                // Add some padding at the bottom
            }
            .frame(height: 180) // Set VStack height equal to ScrollView height
                    .edgesIgnoringSafeArea(.bottom)
                    .background(Color.gray.opacity(0.2))

        })
    })
}

struct RoundedTopCornersShape: Shape {
    var cornerRadius: CGFloat = 16

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }


}
