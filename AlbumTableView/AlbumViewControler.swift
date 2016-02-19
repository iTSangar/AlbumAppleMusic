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
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    view.backgroundColor = Color.Covers.Krit.background
    self.navigationController?.navigationBar.tintColor = Color.Covers.Krit.background
    animateTableView()
    self.setStatusBarStyle(UIStatusBarStyleContrast)
  }

  @IBAction func shop() {
    print("shop")
  }
  
  func animateTableView() {
    tableView.contentInset = UIEdgeInsets(top: tableViewOffset, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -tableViewOffset)
    canAnimate = true
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    if !canAnimate {
      return
    }
    
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
      } else {
        self.navigationController?.navigationBar.tintColor = Color.Covers.Krit.background
      }
    }

//    if scrollView.contentOffset.y != -beforeAppearOffset {
//
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
  
  func infoCellColor(cell: InfoTableCell) {
    cell.gradientBackground.backgroundColor = GradientColor(.TopToBottom, frame: cell.gradientBackground.frame, colors: [UIColor.clearColor(), Color.Covers.Krit.background, Color.Covers.Krit.background])
    cell.albumName.textColor = Color.Covers.Krit.text
    cell.artistName.textColor = Color.Covers.Krit.text
    cell.countPlay.textColor = Color.Covers.Krit.text
    cell.countLike.textColor = Color.Covers.Krit.text
    cell.countComment.textColor = Color.Covers.Krit.text
    cell.likeImage.tintImageColor(Color.Covers.Krit.button)
    cell.playImage.tintImageColor(Color.Covers.Krit.button)
    cell.commentImage.tintImageColor(Color.Covers.Krit.button)
    cell.shareButton.tintButtonColor(Color.Covers.Krit.button)
    cell.playlistButton.tintButtonColor(Color.Covers.Krit.button)
    cell.commentsButton.tintButtonColor(Color.Covers.Krit.button)
  }
  
  func trackCellColor(cell: TrackTableCell) {
    cell.backgroundColor = Color.Covers.Krit.background
    cell.trackNumberLabel.textColor = Color.Covers.Krit.subtext
    cell.trackNameLabel.textColor = Color.Covers.Krit.text
    cell.trackTimeLabel.textColor = Color.Covers.Krit.subtext
    cell.moreButton.tintButtonColor(Color.Covers.Krit.button)
  }

}

extension AlbumViewController: RainbowColorSource {
  func navigationBarInColor() -> UIColor {
    return UIColor.clearColor()
  }
}

extension AlbumViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return indexPath.row == 0 ? 160 : 60
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 0 {
      infoCellColor(cell as! InfoTableCell)
      return
    }
    
    let trackCell = cell as! TrackTableCell
    trackCell.trackNumberLabel.text =  "\(indexPath.row)"
    
    trackCellColor(trackCell)
  }

}

extension AlbumViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    if indexPath.row == 0 {
      cell = tableView.dequeueReusableCell(indexPath: indexPath) as InfoTableCell
    } else {
      cell = tableView.dequeueReusableCell(indexPath: indexPath) as TrackTableCell
    }
    return cell
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


class InfoTableCell: UITableViewCell, Reusable {
  @IBOutlet private var gradientBackground: UIView!
  @IBOutlet private var commentsButton: UIButton!
  @IBOutlet private var playlistButton: UIButton!
  @IBOutlet private var shareButton: UIButton!
  @IBOutlet private var commentImage: UIImageView!
  @IBOutlet private var playImage: UIImageView!
  @IBOutlet private var likeImage: UIImageView!
  @IBOutlet private var albumName: UILabel!
  @IBOutlet private var artistName: UILabel!
  @IBOutlet private var countPlay: UILabel!
  @IBOutlet private var countLike: UILabel!
  @IBOutlet private var countComment: UILabel!
}

class AlbumHeader: UIView {
  @IBOutlet var gradientBackground: UIView!
  @IBOutlet var albumName: UILabel!
  @IBOutlet var artistName: UILabel!
  @IBOutlet var countPlay: UILabel!
  @IBOutlet var countLike: UILabel!
  @IBOutlet var countComment: UILabel!
}
