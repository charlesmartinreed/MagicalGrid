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
    
    //MARK:- Tracking the panned cell(s)
    var selectedCell: UIView? //optional because it begins as nil
    
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
        guard let cellView = cells[key] else { return }
        
        if selectedCell != cellView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                //transform back to 1x scale
                self.selectedCell?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        //brings the cellView to the forefront so we can see it being scaled
        view.bringSubviewToFront(cellView)
        
        //MARK:- Animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            //animate the scale of the grid at that cellView location
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        })
        
        if gesture.state == .ended { //when the user release's their ouch
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                //scale back to original, 1x scale and make it snappy
                cellView.layer.transform = CATransform3DIdentity
                
            })
        }
        
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

