//
//  ViewController.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
  private var game : Game! = nil
  private var map : SKTileMapNode! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let sview = self.view as! SKView
    let scene = SKScene(fileNamed: "GameScene")!
    scene.scaleMode = .aspectFill
    game = Game()
    map = scene.childNode(withName: "//tileMap") as? SKTileMapNode
    
    updateView(response: game.get())
    sview.presentScene(scene)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  }
  
  private func updateView(response: Game.Response) {
    for i in 0...9 {
      for j in 0...9 {
        map.setTileGroup(map.tileSet.tileGroups[response.textureMap![i][j]], forColumn: i, row: j)
      }
    }
  }
}
