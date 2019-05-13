//
//  ResizeView.swift
//  FluidTouchCG
//
//  Created by NSMeter on 12/05/19.
//  Copyright © 2019 Fluid Touch. All rights reserved.
//

import UIKit


class ResizeView: UIView {
    
    private var isResizingLR = false
    private var isResizingUL = false
    private var isResizingUR = false
    private var isResizingLL = false
    private var touchStart = CGPoint.zero
    
    private let kResizeThumbSize: CGFloat = 45.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.drawView(rect: self.frame)
    }
    
    // MARK: Touch Delegates
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.superview?.bringSubviewToFront(self)
        
        touchStart = touches.first!.location(in: self)
        isResizingLR = bounds.size.width - touchStart.x < kResizeThumbSize && bounds.size.height - touchStart.y < kResizeThumbSize
        isResizingUL = touchStart.x < kResizeThumbSize && touchStart.y < kResizeThumbSize
        isResizingUR = bounds.size.width - touchStart.x < kResizeThumbSize && touchStart.y < kResizeThumbSize
        isResizingLL = touchStart.x < kResizeThumbSize && bounds.size.height - touchStart.y < kResizeThumbSize
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touchPoint = touches.first!.location(in: self)
        let previous: CGPoint? = touches.first?.previousLocation(in: self)
        let deltaWidth: CGFloat = (touchPoint.x) - (previous?.x ?? 0.0)
        let deltaHeight: CGFloat = (touchPoint.y) - (previous?.y ?? 0.0)
        
        // get the frame values so we can calculate changes below
        let x: CGFloat = frame.origin.x
        let y: CGFloat = frame.origin.y
        let width: CGFloat = frame.size.width
        let height: CGFloat = frame.size.height
        
        if isResizingLR {
            frame = CGRect(x: x, y: y, width: touchPoint.x + deltaWidth, height: touchPoint.y + deltaWidth)
        } else if isResizingUL {
            frame = CGRect(x: x + deltaWidth, y: y + deltaHeight, width: width - deltaWidth, height: height - deltaHeight)
        } else if isResizingUR {
            frame = CGRect(x: x, y: y + deltaHeight, width: width + deltaWidth, height: height - deltaHeight)
        } else if isResizingLL {
            frame = CGRect(x: x + deltaWidth, y: y, width: width - deltaWidth, height: height + deltaHeight)
        } else {
            // not dragging from a corner -- move the view
            center = CGPoint(x: center.x + touchPoint.x - touchStart.x, y: center.y + touchPoint.y - touchStart.y)
        }
        
        self.drawView(rect: self.frame)
    }
    
    // MARK: Custom Helper Methods
    func drawView(rect: CGRect) {
        //to be impelmented by subclass to draw desire shape
    }
    
    func drawDashedLine() {
        let viewBorder = CAShapeLayer()
        viewBorder.strokeColor = UIColor.black.cgColor
        viewBorder.lineDashPattern = [3, 2]
        viewBorder.frame = self.bounds
        viewBorder.fillColor = nil
        viewBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(viewBorder)
    }
}

