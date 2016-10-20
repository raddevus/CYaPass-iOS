//
//  UserPath.swift
//  CYaPass
//
//  Created by roger deutsch on 10/9/16.
//  Copyright © 2016 roger deutsch. All rights reserved.
//

import Foundation
import CoreGraphics

class UserPath {
    
    var allPoints :[CGPoint]! = []
    var allSegments : Set<Segment> = Set<Segment>()
    var PostPoints : String!
    var PostValue : Int!
    var currentPoint : CGPoint = CGPoint.zero
    var previousPostValue : Int!
    
    init(){
        self.PostValue = 0
    }
    
    func append(currentPoint:CGPoint, postValue : Int) {
        self.currentPoint = currentPoint
        
        if allPoints.count >= 1{
            if (allPoints[allPoints.count-1].x == currentPoint.x && allPoints[allPoints.count - 1].y == currentPoint.y){
                return;
            }
            allSegments.insert(Segment(begin: allPoints[allPoints.count - 1], end: currentPoint, pointValue: postValue + previousPostValue))
        }
        
        allPoints.append(currentPoint)
        previousPostValue = postValue;
    }
    
    func CalculateGeometricSaltValue(){
        self.PostValue = 0;
        for s in allSegments{
            self.PostValue = self.PostValue + s.PointValue
        }
    }
}

class Segment : Hashable{
    var Begin : CGPoint
    var End : CGPoint
    var PointValue : Int
    init(begin :CGPoint, end :CGPoint, pointValue : Int) {
        Begin = begin
        End = end
        PointValue = pointValue
    }
    var hashValue : Int {
        get {
                let hashOut : Int = Int("\(self.Begin.x),\(self.Begin.y),\(self.End.x)\(self.End.y)".hashValue) / 10000
                let hashOut2 : Int = Int("\(self.End.x),\(self.End.y),\(self.Begin.x)\(self.Begin.y)".hashValue) / 10000
                return hashOut + hashOut2
            }
    }
    static func ==(lhs: Segment, rhs: Segment) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
