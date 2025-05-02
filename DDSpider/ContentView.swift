//
//  ContentView.swift
//  DDSpider
//
//  Created by joe on 4/30/25.
//

import SwiftUI

struct ContentView: View {
    let dots: [CGPoint]
    let n = 200
    
    init() {
        self.dots = (0..<n)
            .map { _ in
                CGPoint(
                    x: CGFloat.random(in: 0...1),
                    y: CGFloat.random(in: 0...1)
                )
            }
    }
    
    let dotRadius = 2.5
    @State private var dragLocation: CGPoint = CGPoint(
        x: CGFloat.random(in: 100...200),
        y: CGFloat.random(in: 100...200)
    )
    let radiusOfInfluence = 0.3 // in values between 0 and 1
    let dragDotRadius = 5.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Canvas { context, size in
                let circleRect = CGRect(
                    x: dragLocation.x - dragDotRadius,
                    y: dragLocation.y - dragDotRadius,
                    width: dragDotRadius * 2,
                    height: dragDotRadius * 2
                )
                
                let dragDot = Path(ellipseIn: circleRect)
                
                drawDotsAndLines(
                    context: context,
                    size: size,
                    dots: dots,
                    dotRadius: dotRadius,
                    dragLocation: .zero,
                    radiusOfInfluence: radiusOfInfluence
                )
                
                context.fill(dragDot, with: .color(.red))
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        dragLocation = value.location
                    }
            )
        }
    }
    
    func drawDotsAndLines(
        context: GraphicsContext,
        size: CGSize,
        dots: [CGPoint],
        dotRadius: CGFloat,
        dragLocation: CGPoint,
        radiusOfInfluence: CGFloat
    ) {
        for dot in dots {
            let actualX = dot.x * size.width
            let actualY = dot.y * size.height
            
            let dim = dotRadius * 2
            
            let circle = Path(
                ellipseIn: CGRect(
                    x: actualX - dotRadius,
                    y: actualY - dotRadius,
                    width: dim,
                    height: dim
                )
            )
            
            context.fill(circle, with: .color(.blue))
        }
    }
}

#Preview {
    ContentView()
}
