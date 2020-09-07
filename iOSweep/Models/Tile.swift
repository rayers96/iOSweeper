//
//  Tile.swift
//  iOSweep
//
//  Created by Ryan Ayers on 9/6/20.
//  Copyright © 2020 Ryan Ayers. All rights reserved.
//

import Foundation

class Tile {
  var mine : Bool
  var flipped : Bool
  var flagged : Bool
  var adj : Int
  
  init() {
    mine = false;
    flipped = false;
    flagged = false;
    adj = 0;
  }
}
