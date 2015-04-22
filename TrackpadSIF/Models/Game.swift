//
//  Game.swift
//  TrackpadSIF
//
//  Created by Kawazure on 2015/04/22.
//  Copyright (c) 2015年 kwzrhouse. All rights reserved.
//

import SpriteKit

class Button: SKShapeNode {
    let x, y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        var arc = CGPathCreateMutable()
        CGPathAddArc(arc, nil, CGFloat(x), CGFloat(y), CGFloat(28), CGFloat(0), CGFloat(M_PI * 2), true)
        
        antialiased = true
        strokeColor = SKColor.whiteColor()
        fillColor = SKColor.whiteColor().colorWithAlphaComponent(0.5)
        lineWidth = 2
        path = arc
    }
}

class SIFScene: SKScene {
    var fingers: [Int:NSPoint] = [:]
    
    override init(size: CGSize) {
        super.init(size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = NSColor.blackColor()
        
        for i in 0 ..< 9 {
            let angle = M_PI * Double(i) * 22.5 / 180
            let x = Int(size.width) / 2 + Int(cos(angle) * 186.0)
            let y = Int(size.height) - 70 - Int(sin(angle) * 180.0)
            addChild(Button(x: x, y: y))
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
    }
    
    func beganTaps(taps: Set<NSObject>) {
        for object in taps {
            let tap = object as! NSTouch
            
            if let id = tap.identity?.hash {
                let point = tap.normalizedPosition
                let x = Int(point.x * frame.width)
                let y = Int(point.y * frame.height)
                
                fingers[id] = NSPoint(x: x, y: y)
            }
        }
    }
    
    func endedTaps(taps: Set<NSObject>) {
        for object in taps {
            let tap = object as! NSTouch
            
            if let id = tap.identity?.hash {
                fingers.removeValueForKey(id)
            }
        }
    }
}