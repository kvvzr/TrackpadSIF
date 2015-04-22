//
//  GameView.swift
//  TrackpadSIF
//
//  Created by Kawazure on 2015/04/22.
//  Copyright (c) 2015年 kwzrhouse. All rights reserved.
//

import SpriteKit

class SIFView: NSView {
    var scene: SIFScene?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        acceptsTouchEvents = true
        wantsRestingTouches = true
        
        scene = SIFScene(size: frame.size)
        
        let gameView = SKView(frame: self.frame)
        gameView.presentScene(scene)
        addSubview(gameView)
    }

    override func touchesBeganWithEvent(event: NSEvent) {
        let touches = event.touchesMatchingPhase(NSTouchPhase.Began, inView: self)
        
        if let scene = scene {
            scene.beganTaps(touches)
        }
    }
    
    override func touchesEndedWithEvent(event: NSEvent) {
        let touches = event.touchesMatchingPhase(NSTouchPhase.Ended, inView: self)
        
        if let scene = scene {
            scene.endedTaps(touches)
        }
    }
}