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
    func append(currentPoint:CGPoint, postValue : Int) {
        self.currentPoint = currentPoint
        
        if allPoints.count == 0{
           self.PostValue =  postValue
            self.PostPoints = "\(postValue)" + "_"
        }
        if allPoints.count > 0{
            let segmentCount :Int = allSegments.count
            allSegments.insert(Segment(begin: allPoints[allPoints.count-1],end: currentPoint))
            if allSegments.count > segmentCount{
                // if the segment was added there is a new postPoint
                self.PostValue = self.PostValue + postValue
  
                self.PostPoints = self.PostPoints + "\(postValue)" + "_"
            }
        }
        allPoints.append(currentPoint)
    }
    /*func CheckForDuplicate() ->Bool{
        for p in allPoints as! [CGPoint]{
            if (p.x == currentPoint.x && p.y == currentPoint.y){
                return true;
            }
        }
        return false;
    }*/
    
    func CalculateGeometricSaltValue(){
        
    }
}

class Segment : Hashable{
    var Begin : CGPoint
    var End : CGPoint
    init(begin :CGPoint, end :CGPoint) {
        Begin = begin
        End = end
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
