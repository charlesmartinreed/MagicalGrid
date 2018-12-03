//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Charles Martin Reed on 12/2/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK:- Num of boxes on screen logic
        let numViewPerRow = 15
        let height = Int(view.frame.height) / numViewPerRow
        let width = Int(view.frame.width) / numViewPerRow
        
        //loop for rendering out more boxes
        for j in 0...height {
            for i in 0...numViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: i * width, y: j * width, width: width, height: width) //starting in top-left
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                view.addSubview(cellView)
            }
        }
        
        //MARK:- Gesture recognizer
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    //MARK:- Pan handler
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        //ths will change as the user pans, or drags their finger, across the view
        let location = gesture.location(in: view) //returns a CGPoint
    }

    fileprivate func randomColor() -> UIColor {
        
        let red = CGFloat(drand48()) //a double, random number from 0-1
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }

}

