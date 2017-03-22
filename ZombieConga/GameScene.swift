//
//  GameScene.swift
//  ZombieConga
//
//  Created by harry bloch on 9/29/16.
//  Copyright (c) 2016 harry bloch. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = -1
        addChild(background)
        zombie.position = CGPoint(x: 400, y: 400)
        addChild(zombie)
    }
    
    override func update(currentTime: NSTimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0 }
        lastUpdateTime = currentTime
    
        moveSprite(zombie, velocity: velocity)
    }
    
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint){
            let amountToMove = CGPoint(x: velocity.x * CGFloat(dt),y: velocity.y * CGFloat(dt))
            print("Amount to move: \(amountToMove)")
            sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y
            + amountToMove.y)
    }
    
    func moveZombieToward(location: CGPoint){
        let offset = CGPoint(x: location.x - zombie.position.x, y: location.y - zombie.position.y)
        let length = sqrt(Double(offset.x * offset.x * offset.y * offset .y))
                let direction = CGPoint(x: offset.x / CGFloat(length),y: offset.y / CGFloat(length))
                velocity = CGPoint(x: direction.x * zombieMovePointsPerSec,y: direction.y * zombieMovePointsPerSec)
    }
    
    func sceneTouched(touchLocation:CGPoint) {
            moveZombieToward(touchLocation)
    }
    override func touchesBegan(touches: Set<UITouch>,
            withEvent event: UIEvent?) {
            guard let touch = touches.first else {
            return
            }
            let touchLocation = touch.locationInNode(self)
            sceneTouched(touchLocation)
    }
    override func touchesMoved(touches: Set<UITouch>,withEvent event: UIEvent?) {
            guard let touch = touches.first else {
            return
            }
            let touchLocation = touch.locationInNode(self)
            sceneTouched(touchLocation)
    }}


