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

private let tableViewOffset: CGFloat = UIScreen.mainScreen().bounds.height < 600 ? 245 : 265
private let beforeAppearOffset: CGFloat = 350


class AlbumViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var header: AlbumHeader!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView(frame: CGRectZero)
    tableView.tableHeaderView = header
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    animateTableView()
    self.setStatusBarStyle(UIStatusBarStyleContrast)
  }

  @IBAction func shop() {
    print("shop")
  }
  
  func animateTableView() {
    tableView.contentInset = UIEdgeInsets(top: tableViewOffset, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -beforeAppearOffset)
    UIView.animateWithDuration(0.5, animations: {
      self.tableView.contentOffset = CGPoint(x: 0, y: -tableViewOffset)
    })
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let themeColor = UIColor(red: 247/255.0, green: 80/255.0, blue: 120/255.0, alpha: 1.0)
    
    print(scrollView.contentOffset.y)
    
//    if scrollView.contentOffset.y != -beforeAppearOffset {
//      let offsetY = scrollView.contentOffset.y
//      if offsetY >= 0 {
//        let height = self.tableView.tableHeaderView!.bounds.height
//        let maxOffset = height - 64
//        
//        var progress = (scrollView.contentOffset.y - 64) / maxOffset
//        progress = min(progress, 1)
//        
//        self.navigationController?.navigationBar.df_setBackgroundColor(themeColor.colorWithAlphaComponent(progress))
//      }
//      
//    }
  }

}

extension AlbumViewController: RainbowColorSource {
  func navigationBarInColor() -> UIColor {
    return UIColor.clearColor()
  }
}

extension AlbumViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    let trackCell = cell as! TrackTableCell
    trackCell.trackNumberLabel.text =  "\(indexPath.row + 1)"
    trackCell.trackNameLabel.preferredMaxLayoutWidth = 100
    trackCell.trackNameLabel.text = "Big Music Name With Feat Special Single All"
  }

}

extension AlbumViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(indexPath: indexPath) as TrackTableCell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 16
  }
}

class TrackTableCell: UITableViewCell, Reusable {
  @IBOutlet private weak var trackNameLabel: UILabel!
  @IBOutlet private weak var trackNumberLabel: UILabel!
  @IBOutlet private weak var trackTimeLabel: UILabel!
  @IBOutlet private weak var moreButton: UIButton!
}

class AlbumHeader: UIView {
  @IBOutlet var gradientBackground: UIView!
  @IBOutlet var albumName: UILabel!
  @IBOutlet var artistName: UILabel!
  @IBOutlet var countPlay: UILabel!
  @IBOutlet var countLike: UILabel!
  @IBOutlet var countComment: UILabel!
}
