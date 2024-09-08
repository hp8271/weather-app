//
//  LineProgressView.swift
//  Weather
//
//  Created by Harsh Pranay on 12/08/24.
//

import SwiftUI

struct LineProgressView: View {
    @State private var progress: Double = 0.0
    var secondsToComplete: Double
    private var onCompletion: () -> Void
    
    init(secondsToComplete: Double, onCompletion: @escaping () -> Void) {
        self.secondsToComplete = secondsToComplete
        self.onCompletion = onCompletion
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: secondsToComplete)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
                
            
            Text("Loading...")
                .padding(.top, 10)
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.regular)
        }
        .onAppear {
            startProgress()
        }
    }

    func startProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if progress < secondsToComplete {
                progress += 0.01
            } else {
                timer.invalidate()
                onCompletion()
            }
        }
    }
}


#Preview {
    LineProgressView(secondsToComplete: 1){}
}
