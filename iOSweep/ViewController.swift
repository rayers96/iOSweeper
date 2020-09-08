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
  private var scene : SKScene! = nil
  private var map : SKTileMapNode! = nil
  private var game : Game! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let v = self.view as! SKView
    scene = SKScene(fileNamed: "GameScene")!
    scene.scaleMode = .aspectFill
    map = scene.childNode(withName: "//tileMap") as? SKTileMapNode
    game = Game(viewController: self)
    v.presentScene(scene)
  }
  
  @IBAction func tapped(_ sender: UITapGestureRecognizer) {
    let location = sender.location(in: sender.view)
    let locationInScene = scene.convertPoint(fromView: location)
    let locationInNode = scene.convert(locationInScene, to: map)
    let x = map.tileColumnIndex(fromPosition: locationInNode)
    let y = map.tileRowIndex(fromPosition: locationInNode)
    game.flip(x: x, y: y)
  }
  @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
    if (sender.state == UIGestureRecognizer.State.began) {
      let location = sender.location(in: sender.view)
      let locationInScene = scene.convertPoint(fromView: location)
      let locationInNode = scene.convert(locationInScene, to: map)
      let x = map.tileColumnIndex(fromPosition: locationInNode)
      let y = map.tileRowIndex(fromPosition: locationInNode)
      game.toggleFlag(x: x, y: y)
    }
  }
  @IBAction func newGame(_ sender: UIButton) {
    viewDidLoad()
  }
  
  func updateView(r: Response) {
    for i in 0...9 {
      for j in 0...9 {
        map.setTileGroup(map.tileSet.tileGroups[r.textureMap[i][j]], forColumn: i, row: j)
      }
    }
    if (r.status != 0) {
      // Loss/win message
    }
  }
}
