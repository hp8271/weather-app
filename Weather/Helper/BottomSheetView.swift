//
//  BottomSheetView.swift
//  Weather
//
//  Created by Harsh Pranay on 13/08/24.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    let height: CGFloat?
    let shouldAnimate: Bool
    let animationDuration: Double
    let cornerRadius: CGFloat
    let isScrollable: Bool
    let content: () -> Content

    @State private var offset: CGFloat = MobileBounds.height
@State private var contentHeight: CGFloat = 0

    init(
        isPresented: Binding<Bool>,
        height: CGFloat? = nil,
        shouldAnimate: Bool = true,
        animationDuration: Double = 0.3,
        cornerRadius: CGFloat = 16,
        isScrollable: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.height = height
        self.shouldAnimate = shouldAnimate
        self.animationDuration = animationDuration
        self.cornerRadius = cornerRadius
        self.isScrollable = isScrollable
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    if isScrollable {
                        ScrollView {
                            content()
                                .background(GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            contentHeight = geo.size.height
                                        }
                                })
                        }
                    } else {
                        content()
                            .background(GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        contentHeight = geo.size.height
                                    }
                            })
                    }
                }
                .frame(width: geometry.size.width, height: height ?? contentHeight)
                .background(Color.white)
                .cornerRadius(cornerRadius)
                .shadow(radius: 10)
                .offset(y: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newOffset = value.translation.height + offset
                            if newOffset > 0 {
                                offset = newOffset
                            }
                        }
                        .onEnded { value in
                            if value.translation.height > 200 { // Threshold for dismiss
                                withAnimation(.easeInOut(duration: animationDuration)) {
                                    isPresented = false
                                }
                            } else {
                                withAnimation(.easeInOut(duration: animationDuration)) {
                                    offset = UIScreen.main.bounds.height - (height ?? contentHeight)
                                }
                            }
                        }
                )
                .onAppear {
                    if shouldAnimate {
                        withAnimation(.easeInOut(duration: animationDuration)) {
                            offset = UIScreen.main.bounds.height - (height ?? contentHeight)
                        }
                    } else {
                        offset = UIScreen.main.bounds.height - (height ?? contentHeight)
                    }
                }
            }
            .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
        }
        .edgesIgnoringSafeArea(.all) // Ensures the bottom sheet covers the entire screen
    }
}

//#Preview {
//    @State var isSheetPresented: Bool = false
//
//    BottomSheetView(isPresented: $isSheetPresented, height: 500, content: {
//        Text("ABCD")
//    })
//}
