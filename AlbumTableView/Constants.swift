//
//  Constants.swift
//  AlbumTableView
//
//  Created by Ítalo Sangar on 2/10/16.
//  Copyright © 2016 iTSangar. All rights reserved.
//

import Foundation
import ChameleonFramework

struct Color {
  struct Covers {
    struct Krit {
      static let background = UIColor(hexString: "140E30")
      static let text1 = UIColor(hexString: "FAFBFC")
      static let text2 = UIColor(hexString: "604480")
      static let button = UIColor(hexString: "B39276")
    }
    
    struct Wayne {
      static let background = UIColor(hexString: "272934")
      static let text1 = UIColor(hexString: "B0AAAF")
      static let text2 = UIColor(hexString: "251F1F")
      static let button = UIColor(hexString: "FC5C66")
    }
  }
}

extension UIImageView {
  func tintImageColor(color : UIColor) {
    self.image = self.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    self.tintColor = color
  }
}

extension UIButton {
  func tintButtonColor(color : UIColor) {
    let tinted = self.currentImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    self.setImage(tinted, forState: self.state)
    self.tintColor = color
  }
}