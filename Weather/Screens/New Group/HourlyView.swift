//
//  HourlyView.swift
//  Weather
//
//  Created by Harsh Pranay on 17/08/24.
//

import SwiftUI

struct HourlyView: View {

    let time: String
    let image: ImagesValue
    let temp: String
    let percentage: Int?

    @State private var isSelected: Bool
    init(time: String, image: ImagesValue, temp: String, percentage: Int? = nil, isSelected: Bool) {
        self.time = time
        self.image = image
        self.temp = temp
        self.percentage = percentage
        self.isSelected = isSelected
    }

    var body: some View {
        //        Capsule()
        //            .stroke(Color.blue, lineWidth: 3)
        //            .background(Color.clear)
        ZStack {
            Capsule()
                .stroke(Color.purple, lineWidth: 3)  // Capsule border
                .background(Capsule().fill(Color(hex: "#48319D").opacity(isSelected ? 1 : 0.65))) // Transparent background

            // Content inside the capsule
            VStack {
                Text(time)
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .padding(.top, 16)
                Spacer()
                Image(systemName: image.rawValue)
                    .foregroundColor(.blue)
                    .frame(width: 32, height: 32)
                if let percentage = percentage {
                    Text("\(percentage)%")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#40CBD8"))
                        .fontWeight(.regular)
                }
                Spacer()
                Text(temp+"°")
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .padding(.bottom, 16)
            }
        }
        .frame(width: 70, height: 160)
    }
}

#Preview {
    HourlyView(time: "12 PM", image: .tornado, temp: "30", percentage: 30, isSelected: false)
}
