//
//  ShapeView.swift
//  FluidTouchCG
//
//  Created by NSMeter on 10/05/19.
//  Copyright © 2019 Fluid Touch. All rights reserved.
//

import UIKit

class ShapeView: ResizeView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var type : Shapes?
    private var imageRect : CGRect?

    
    override func drawView(rect: CGRect) {
        
        removePreviousPath()
        imageRect = rect
        if let _  = type{
        switch type! {
        case .Rectangle:
            drawRectangle()
        case .Ellipse:
            drawEllipse()
        case .Triangle:
            drawTriangle()
        case .Star:
            drawStar()
        }
    }
       super.drawDashedLine()
    }
    
    // MARK: Draw various shapes
    func drawRectangle() {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageRect!.size.width, height: imageRect!.size.height))
        
        let rectImage = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: imageRect!.size.width, height: imageRect!.size.height)
            
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fill)
        }
        
        addToLayer(image: rectImage)
        
    }
    
    
    func drawEllipse() {
       
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageRect!.size.width, height: imageRect!.size.height))
        
        let ellipse = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: imageRect!.size.width, height: imageRect!.size.height)
            ctx.cgContext.setFillColor(UIColor.blue.cgColor)

            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fill)
        }
        
        addToLayer(image: ellipse)
    }
    
    func drawTriangle(){

        let renderer1 = UIGraphicsImageRenderer(size: CGSize(width: imageRect!.size.width, height: imageRect!.size.height))
        let triangleImage = renderer1.image { ctx in
            UIColor.brown.setFill()
            UIColor.purple.setStroke()
            ctx.cgContext.move(to: CGPoint(x: imageRect!.size.width/2, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 0.0, y: imageRect!.size.height))
            ctx.cgContext.addLine(to: CGPoint(x: imageRect!.size.width, y: imageRect!.size.height))
            ctx.cgContext.addLine(to: CGPoint(x: imageRect!.size.width/2, y: 0))
            
            let rectangle = CGRect(x: 0, y: 0, width: imageRect!.size.width, height: imageRect!.size.height)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .stroke)
        }
        addToLayer(image: triangleImage)

    }
    
    
    func drawStar(){
        
        let path = UIBezierPath()
        
        let starExtrusion:CGFloat = 30.0
        
        let center = CGPoint(x: imageRect!.size.width / 2.0, y: imageRect!.size.height / 2.0)
        
        let pointsOnStar = 5
        
        var angle:CGFloat = -CGFloat(.pi / 2.0)
        let angleIncrement = CGFloat(.pi * 2.0 / Double(pointsOnStar))
        let radius = self.frame.width / 2.0
        
        var firstPoint = true
        
        for _ in 1...pointsOnStar {
            
            let point = pointFrom(angle: angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle: angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angle: angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
            
            if firstPoint {
                firstPoint = false
                path.move(to: point)
            }
            
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            
            angle += angleIncrement
        }
        
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 1.0
        self.layer.addSublayer(shapeLayer)
        
    }
    
    // MARK: Custom Helper Methods
    private func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
    }
    
    private  func addToLayer(image : UIImage){
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.contents = image.cgImage
        self.layer.addSublayer(shapeLayer)
        
    }
    
    private func removePreviousPath(){
        //to remove previous drawn path
        self.layer.sublayers = nil
    }
}




