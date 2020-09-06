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
  
  override func didMove(to view: SKView) {
    // Get tileMap node from scene and fill with default texture
    self.map = self.childNode(withName: "//tileMap") as? SKTileMapNode
    map?.fill(with: map?.tileSet.tileGroups[0])
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
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
  }

  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
}
