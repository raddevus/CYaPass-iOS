//
//  GridPassView.swift
//  CYaPass
//
//  Created by roger deutsch on 10/9/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import Foundation
import UIKit

class GridPassView : UIView{
    var touchPoints : [CGPoint]! = []
    
    var Width : Int! = nil
    var Height : Int! = nil
    var hitTestIdx : Int! = nil
    
    let gridBackColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    let gridPostColor = UIColor(red: 255/255.0, green: 69/255.0, blue: 0/255.0, alpha: 1.0)
    let blueFontColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 240/255.0, alpha: 1.0)
    let lineColor = UIColor(red: 0/255.0, green: 99/255.0, blue: 0/255.0, alpha: 1.0)
    let transparent = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
    var cellSize : Int = 0
    var numOfCells :Int = 0
    var previousPointExists : Bool = false

    var allPosts : [CGPoint]! = []

    var us : UserPath = UserPath()
    var currentLocation : CGPoint! = nil
    var previousPoint : CGPoint! = nil
    let postWidth :Int = 5
    let postXOffset : Int = 0
    
    init(frame : CGRect, width: Int, height: Int){
        
        
        super.init(frame: frame)
        self.backgroundColor = transparent//gridBackColor
        self.Width = width
        self.Height = height
        self.numOfCells = 5
        var maxCells : Int = numOfCells + 1
        self.cellSize = Int(height / numOfCells)
        generateAllPosts()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect)
    {
        drawPosts()
        drawGridLines()
        DrawUserPath()
    }
    
    internal func drawPosts()
    {
        //let halfSize:CGFloat = min( bounds.size.width/2, bounds.size.height/2)
        
        let desiredLineWidth:CGFloat = 3    // your desired value
        //var allPaths : [UIBezierPath]
        for idx in 0...allPosts.count-1 {
            
            let circlePath = UIBezierPath(
                arcCenter: CGPoint(x:allPosts[idx].x,y:allPosts[idx].y),
                radius: CGFloat( postWidth),
                startAngle: CGFloat(0),
                endAngle:CGFloat(M_PI * 2),
                clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            
            shapeLayer.fillColor = gridPostColor.cgColor
            shapeLayer.strokeColor = gridPostColor.cgColor
            shapeLayer.lineWidth = desiredLineWidth
            
            self.layer.addSublayer(shapeLayer)
        }
    }
    
    func generateAllPosts(){
        for x in 0...numOfCells{
            for y in 0...numOfCells{
                allPosts.append(CGPoint(x:(x*cellSize)+postXOffset,y:(y*cellSize)))
            }
        }
    }
    
    func drawGridLines(){
        
        // RAD- Draw horizontal lines
        for cellCount in 0...numOfCells{
      
        //create the path
        var plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = 1.5
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.move(to: CGPoint(
            x:0+postXOffset,
            y:(cellCount*cellSize)))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x:(numOfCells*cellSize)+postXOffset,
            y:(cellCount*cellSize)))
        
        //set the stroke color
        UIColor.black.setStroke()
        
        //draw the stroke
        plusPath.stroke()
        }
        
        // RAD- Draw vertical lines
        for cellCount in 0...numOfCells{
            
            //create the path
            var plusPath = UIBezierPath()
            
            //set the path's line width to the height of the stroke
            plusPath.lineWidth = 2
            
            //move the initial point of the path
            //to the start of the horizontal stroke
            plusPath.move(to: CGPoint(
                x:(cellCount*cellSize)+postXOffset,
                y:0))
            
            //add a point to the path at the end of the stroke
            plusPath.addLine(to: CGPoint(
                x:(cellCount*cellSize)+postXOffset,
                y:(numOfCells*cellSize)))
            
            //set the stroke color
            UIColor.black.setStroke()
            
            //draw the stroke
            plusPath.stroke()
        }
    }
    
    func drawPoint(point1 :CGPoint){
        let circlePath = UIBezierPath(
            arcCenter: point1,
            radius: CGFloat( postWidth + 7 ),
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2),
            clockwise: true)
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = transparent.cgColor
        shapeLayer.strokeColor = blueFontColor.cgColor
        shapeLayer.lineWidth = 3
        
        layer.addSublayer(shapeLayer)
    }
    
    func DrawUserPath(){
        //if us.allSegments.count < 1 {return}
        
        for ls in us.allSegments  {
            var plusPath = UIBezierPath()
            
            //set the path's line width to the height of the stroke
            plusPath.lineWidth = 8
            
            //move the initial point of the path
            //to the start of the horizontal stroke
            plusPath.move(to: CGPoint(
                x:ls.Begin.x,
                y:ls.Begin.y))
            
            //add a point to the path at the end of the stroke
            plusPath.addLine(to: CGPoint(
                x:ls.End.x,
                y:ls.End.y))
            
            //set the stroke color
            lineColor.setStroke()
            
            //draw the stroke
            plusPath.stroke()
        }
        
    }
    
    func HitTest( p : inout CGPoint) -> Bool
    {
        let offset :Int = 15
        
        let x :Int = Int(p.x)
        let y :Int = Int(p.y)
        for idx in 0...(allPosts.count-1)
        {
            
            let minX : Int = (Int(allPosts[idx].x) - offset) - postWidth
            let maxX : Int = (Int(allPosts[idx].x) + offset) + postWidth
            let minY : Int = (Int(allPosts[idx].y) - offset) - postWidth
            let maxY : Int = (Int(allPosts[idx].y) + offset) + postWidth
            if (x >= minX && x <= maxX) {
                if (y >= minY && y <= maxY){
                    p = allPosts[idx];
                    hitTestIdx = idx;
                    return true;
                }
            }
        }
        
        return false;
    }
    
    func SelectNewPoint()
    {
        var currentPoint :CGPoint = currentLocation;
        if (!HitTest(p: &currentPoint))
        {
            return;
        }
        
        us.append(currentPoint: currentPoint, postValue: hitTestIdx)
        us.CalculateGeometricSaltValue()
        DrawHighlight()
    }
    
    func DrawHighlight(){
        if (us.allPoints.count > 0){
            drawPoint(point1: us.allPoints[0])
        }
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            currentLocation = touch.location(in: self)
            SelectNewPoint()
            
            DrawUserPath()
            setNeedsDisplay()
            if us.PostValue != nil{
                MainViewController.cyaSettings.shapeValue = String(us.PostValue)
                self.superview?.touchesBegan(touches, with: event)
            }
        }
    }
}
