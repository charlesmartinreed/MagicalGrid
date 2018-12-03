//
//  ViewController.swift
//  MagicalGrid
//
//  Created by Charles Martin Reed on 12/2/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Cell properties
    let numViewPerRow = 15
    
    var cells = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK:- Num of boxes on screen logic
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
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        
        //MARK:- Gesture recognizer
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    //MARK:- Pan handler
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        //ths will change as the user pans, or drags their finger, across the view
        let location = gesture.location(in: view) //returns a CGPoint
        
        //finding a grid box in our subview
        let height = Int(view.frame.height) / numViewPerRow
        let width = Int(view.frame.width) / numViewPerRow
        
        let i = Int(location.x) / width //the column you're in
        let j = Int(location.y) / width //the row you're in
        
        print(i, j)
        
        //more efficient, uses dictionary
        let key = "\(i)|\(j)"
        let cellView = cells[key]
        cellView?.backgroundColor = .white
        
        //inefficient, for-loop version.
//        for subview in view.subviews {
//            if subview.frame.contains(location) {
//                subview.backgroundColor = .black
//            }
//        }
    }

    fileprivate func randomColor() -> UIColor {
        
        let red = CGFloat(drand48()) //a double, random number from 0-1
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }

}

