//
//  Pie.swift
//  Memorize
//
//  Created by Mustafa Taşdemir on 19.08.2022.
//

import SwiftUI

struct Pie: Shape {

    func path(in rect: CGRect) -> Path {
        let startAngle = Angle(degrees: 270)
        let endAngle = Angle(degrees: 30)
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 * 0.9
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
    
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie()
    }
}
