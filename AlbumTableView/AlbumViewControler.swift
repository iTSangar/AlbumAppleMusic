//
//  AlbumViewControler.swift
//  AlbumTableView
//
//  Created by Ítalo Sangar on 2/3/16.
//  Copyright © 2016 iTSangar. All rights reserved.
//

import UIKit
import Reusable
import RainbowNavigation
import ChameleonFramework

private let tableViewOffset: CGFloat = UIScreen.mainScreen().bounds.height < 600 ? 225 : 245
private let beforeAppearOffset: CGFloat = 350


class AlbumViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  private var canAnimate = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView(frame: CGRectZero)
    UIApplication.sharedApplication().statusBarStyle = .LightContent
    
    view.backgroundColor = Color.Covers.Krit.background
    self.navigationController?.navigationBar.tintColor = Color.Covers.Krit.background
    animateTableView()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    UIApplication.sharedApplication().statusBarStyle = .Default
  }

  @IBAction func shop() {
    print("shop")
  }
  
  func animateTableView() {
    tableView.contentInset = UIEdgeInsets(top: tableViewOffset, left: 0, bottom: 0, right: 0)
    UIView.animateWithDuration(0.5, animations: {
      self.tableView.contentOffset = CGPoint(x: 0, y: -tableViewOffset)
    })
    canAnimate = true
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    if !canAnimate { return }
    
    let offsetY = scrollView.contentOffset.y
    
    if offsetY < -tableViewOffset {
      scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: -tableViewOffset)
    } else if offsetY > -tableViewOffset {
      let maxOffset = tableViewOffset - 64
      var progress = (offsetY + 70) / maxOffset
      progress = min(progress, 1)
      self.navigationController?.navigationBar.df_setBackgroundColor(Color.Covers.Krit.background.colorWithAlphaComponent(progress))
      if progress >= 0.8 {
        self.navigationController?.navigationBar.tintColor = Color.Covers.Krit.text
        UIApplication.sharedApplication().statusBarStyle = .Default
      } else {
        self.navigationController?.navigationBar.tintColor = Color.Covers.Krit.background
        UIApplication.sharedApplication().statusBarStyle = .LightContent
      }
    }
  }
}


extension AlbumViewController: RainbowColorSource {
  func navigationBarInColor() -> UIColor {
    return UIColor.clearColor()
  }
}


extension AlbumViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    switch indexPath.row {
    case 0: return 160
    case 15: return 255
    default: return 60
    }
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    if cell is InfoTableCell {
      let iCell = cell as! InfoTableCell
      if iCell.delegate == nil { iCell.delegate = self }
      iCell.configCellColor()
    } else if cell is TrackTableCell {
      let tCell = cell as! TrackTableCell
      if tCell.delegate == nil { tCell.delegate = self }
      tCell.trackNumberLabel.text = "\(indexPath.row)"
      tCell.configCellColor()
    } else if cell is MoreAlbumCell {
      let mCell = cell as! MoreAlbumCell
      if mCell.delegate == nil { mCell.delegate = self }
      mCell.configCellColor()
    }
  }
}


extension AlbumViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    if indexPath.row == 0 {
      cell = tableView.dequeueReusableCell(indexPath: indexPath) as InfoTableCell
    } else if indexPath.row == 15 {
      cell = tableView.dequeueReusableCell(indexPath: indexPath) as MoreAlbumCell
    }else {
      cell = tableView.dequeueReusableCell(indexPath: indexPath) as TrackTableCell
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 16
  }
}


extension AlbumViewController: AlbumButtonCellDelegate {
  func actionInfoCellTapped(cell: InfoTableCell, type: InfoButtonType) {
    switch type {
    case .Share: print("share tap")
    case .Playlist: print("playlist tap")
    case .Comments: print("comments tap")
    }
  }
  
  func actionTrackCellTapped(cell: TrackTableCell) {
    print("track tap at \(tableView.indexPathForCell(cell)!.row)")
  }
  
  func actionAlbumCellTapped(cell: MoreAlbumCell, type: AlbumButtonType) {
    switch type {
    case .MoreBy: print("moreBy tap")
    case .Cover1: print("cover 1 tap")
    case .Cover2: print("cover 2 tap")
    case .Cover3: print("cover 3 tap")
    }
  }
  
}

