//
//  Pie.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 19.08.2022.
//

import SwiftUI

struct Pie: Shape {

    var endAngle = Angle(degrees: 270.1)
    
    func path(in rect: CGRect) -> Path {
        let startAngle = Angle(degrees: 270)
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 * 0.9
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
    
    mutating func setArc(by angle: Double) {
        endAngle += Angle(degrees: angle)
        if endAngle.degrees >= 630 {
            endAngle.degrees = 630
        }
    }
    
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie()
    }
}
