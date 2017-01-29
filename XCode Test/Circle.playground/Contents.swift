//: Playground - noun: a place where people can play

import UIKit
import Foundation



class Segements {
    
    var shape : CAShapeLayer?
    var boost : Int = -1
    
    func setShape( _ shape : CAShapeLayer ) {
        self.shape = shape
    }
    func getShape() -> CAShapeLayer {
        return self.shape!
    }
    
    func setBoost( _ boost : Int) {
        self.boost = boost
    }
    func getBoost() -> Int {
        return self.boost
    }
    
}

var x :CGFloat = 0
var y :CGFloat = 0
var segments : [Segements] = []

var circleRadius : CGFloat = 150


func getNPointsOnCircle(radius:CGFloat) -> [CGPoint]{
    
    let alpha:CGFloat = 360 / 24;
    var startPoint:CGFloat = 270
    
    var circlePoints = [CGPoint]()
    
    var index = 0
    
    for _ in 0..<24 {
        
        if ( alpha * CGFloat(index) + startPoint ) > 360 {
            index = 0
            startPoint = 15
        }
        
        let theta:CGFloat = alpha * CGFloat(index) + startPoint;
        
        let pointX = x + ( radius * cos(theta.degreesToRadians))
        let pointY = y + ( radius * sin(theta.degreesToRadians))
        let pointOnCircle:CGPoint = CGPoint(x: CGFloat(pointX), y: CGFloat(pointY))
        circlePoints.append(pointOnCircle)
        index = index + 1
    }
    return circlePoints
}


let circlePoints = getNPointsOnCircle(radius: circleRadius + 50)
var index = 0
let start =  (CGFloat(M_PI_2) * 4.0) / 72
let test = start / 1.3
let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: circleRadius, startAngle: CGFloat(M_PI_2) * 3.0 + test , endAngle:CGFloat(M_PI_2) * 3.0 + CGFloat(M_PI) * 2.0 + test, clockwise: true)
let segmentAngle : CGFloat = 1 / 72



for i in 0 ..< 72 {
    
    let circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.cgPath
    
    circleLayer.strokeStart = segmentAngle * CGFloat(i)
    
    let gapSize : CGFloat = 0.008
    circleLayer.strokeEnd = circleLayer.strokeStart + segmentAngle - gapSize
    
    circleLayer.lineWidth = 70
    
    circleLayer.strokeColor = UIColor.blue.cgColor
    
    circleLayer.fillColor = UIColor.white.cgColor
    
    let newSegement = Segements()
    newSegement.setBoost(0)
    newSegement.setShape(circleLayer)
    
    segments.insert(newSegement, at: i)
    view.layer.addSublayer(segments[i].getShape())
    
    if i % 3 == 0 {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 24, height :24))
        label.center = CGPoint(x: circlePoints[index].x, y: circlePoints[index].y)
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        label.text = String(index)
        label.font = UIFont(name: "Avenir Next", size: 16)
        self.view.addSubview(label)
        index = index + 1
        
    }

}

extension CGFloat {
    var doubleValue:      Double  { return Double(self) }
    var degreesToRadians: CGFloat { return CGFloat(doubleValue * M_PI / 180) }
    var radiansToDegrees: CGFloat { return CGFloat(doubleValue * 180 / M_PI) }
}
