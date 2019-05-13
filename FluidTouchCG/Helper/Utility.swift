//
//  Utility.swift
//  FluidTouchCG
//
//  Created by NSMeter on 12/05/19.
//  Copyright © 2019 Fluid Touch. All rights reserved.
//

import UIKit

enum Shapes : String {
    
    case Ellipse, Rectangle, Star, Triangle
    static var allValues = [Shapes.Ellipse, .Rectangle, .Star, .Triangle]
}

extension CGRect{
    
    var randomFrame: CGRect{
       
        return CGRect(x: CGFloat(Float.random(in: Float(self.origin.x)...Float(self.origin.x + self.size.width/2))), y: CGFloat(Float.random(in: Float(self.origin.y)...Float(self.origin.y + self.size.height/2))), width: self.size.width/2, height: self.size.width/2)
    }
    
}
