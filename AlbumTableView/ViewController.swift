//
//  ViewController.swift
//  AlbumTableView
//
//  Created by Ítalo Sangar on 2/2/16.
//  Copyright © 2016 iTSangar. All rights reserved.
//

import UIKit
import RainbowNavigation

class ViewController: UIViewController {
  
  let navColor = UIColor.flatSkyBlueColorDark()
  lazy var rainbowNavigation = RainbowNavigation()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.df_setBackgroundColor(navColor)
    
    if let navigationController = navigationController {
      rainbowNavigation.wireTo(navigationController: navigationController)
    }
  }
  
}

extension ViewController: RainbowColorSource {
  func navigationBarInColor() -> UIColor {
    return navColor
  }
}

