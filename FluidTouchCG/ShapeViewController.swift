//
//  ViewController.swift
//  FluidTouchCG
//
//  Created by NSMeter on 10/05/19.
//  Copyright © 2019 Fluid Touch. All rights reserved.
//

import UIKit

class ShapeViewController: UIViewController {

    @IBOutlet weak var randomContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
    }
   

    @IBAction func addShape(_ barButtonItem: UIBarButtonItem) {
        
        let controller = ArrayChoiceTableViewController(Shapes.allValues) { [unowned self] (shape) in
            
          
            if shape == Shapes.Ellipse {
                let shapeView = ShapeView(frame: self.randomContentView.frame.randomFrame)
                shapeView.type = .Ellipse
                self.view.addSubview(shapeView)
            }
            
            if shape == Shapes.Rectangle {
                let shapeView = ShapeView(frame: self.randomContentView.frame.randomFrame)
                shapeView.type = .Rectangle
                self.view.addSubview(shapeView)
                
            }
            
            if shape == Shapes.Star {
                let shapeView = ShapeView(frame: self.randomContentView.frame.randomFrame)
                shapeView.type = .Star
                self.view.addSubview(shapeView)
            }
            
            if shape == Shapes.Triangle {
                let shapeView = ShapeView(frame: self.randomContentView.frame.randomFrame)
                shapeView.type = .Triangle
                self.view.addSubview(shapeView)
            }
        }
        showPopup(controller , barButtonItem)
    }
    
    private func showPopup(_ controller: UIViewController,_ barButtonItem: UIBarButtonItem) {
        controller.modalPresentationStyle = .popover
        controller.preferredContentSize = CGSize(width: 300, height: 190)
        let presentationController = controller.presentationController as! UIPopoverPresentationController
        if let view: UIView = barButtonItem.value(forKey: "view") as? UIView {
            presentationController.sourceView = view
            presentationController.sourceRect = view.bounds
        }

        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
    }
    
}

