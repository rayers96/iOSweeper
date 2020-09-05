//
//  GameScene.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/5/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  private var map : SKTileMapNode?
  private var spinnyNode : SKShapeNode?
  
  override func didMove(to view: SKView) {
    
    // Get tileMap node from scene and store it for use later
    self.map = self.childNode(withName: "//tileMap") as? SKTileMapNode
    
    // Create shape node to use during mouse interaction
    let w = (self.size.width + self.size.height) * 0.05
    self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
    
    if let spinnyNode = self.spinnyNode {
      spinnyNode.lineWidth = 2.5
      
      spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
      spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                        SKAction.fadeOut(withDuration: 0.5),
                                        SKAction.removeFromParent()]))
    }
  }
  
  func touchDown(atPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
      n.position = pos
      n.strokeColor = SKColor.green
      self.addChild(n)
    }
  }
  
  func touchMoved(toPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
      n.position = pos
      n.strokeColor = SKColor.blue
      self.addChild(n)
    }
  }
  
  func touchUp(atPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
      n.position = pos
      n.strokeColor = SKColor.red
      self.addChild(n)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Demonically changes tile to other kind
    let stone = map?.tileSet.tileGroups[0]
    let grass = map?.tileSet.tileGroups[1]
    let touch = touches.first!
    let positionInMap = touch.location(in: map!)
    let col = map?.tileColumnIndex(fromPosition: positionInMap)
    let row = map?.tileRowIndex(fromPosition: positionInMap)
    let current = map?.tileGroup(atColumn: col!, row: row!)
    if (current == stone) {
      map?.setTileGroup(grass, forColumn: col!, row: row!)
    } else {
      map?.setTileGroup(stone, forColumn: col!, row: row!)
    }

    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }

  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
}
