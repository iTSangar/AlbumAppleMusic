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
  @IBOutlet var header: AlbumHeader!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView(frame: CGRectZero)
    //tableView.tableHeaderView = header
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    animateTableView()
    self.setStatusBarStyle(UIStatusBarStyleContrast)
    header.gradientBackground.backgroundColor = GradientColor(.TopToBottom, frame: header.frame, colors: [UIColor.clearColor(), UIColor(hexString: "B3272A"), UIColor(hexString: "B3272A"), UIColor(hexString: "B3272A")])
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
    //let themeColor = UIColor(red: 247/255.0, green: 80/255.0, blue: 120/255.0, alpha: 1.0)
    
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
  
  func infoCellColor(cell: InfoTableCell) {
    cell.gradientBackground.backgroundColor = GradientColor(.TopToBottom, frame: cell.gradientBackground.frame, colors: [UIColor.clearColor(), Color.Covers.Wayne.background, Color.Covers.Wayne.background])
    cell.albumName.textColor = Color.Covers.Wayne.text1
    cell.artistName.textColor = Color.Covers.Wayne.text1
    cell.countPlay.textColor = Color.Covers.Wayne.text1
    cell.countLike.textColor = Color.Covers.Wayne.text1
    cell.countComment.textColor = Color.Covers.Wayne.text1
    cell.likeImage.tintImageColor(Color.Covers.Wayne.button)
    cell.playImage.tintImageColor(Color.Covers.Wayne.button)
    cell.commentImage.tintImageColor(Color.Covers.Wayne.button)
    cell.shareButton.tintButtonColor(Color.Covers.Wayne.button)
    cell.playlistButton.tintButtonColor(Color.Covers.Wayne.button)
    cell.commentsButton.tintButtonColor(Color.Covers.Wayne.button)
  }
  
  func trackCellColor(cell: TrackTableCell) {
    cell.backgroundColor = Color.Covers.Wayne.background
    cell.trackNumberLabel.textColor = Color.Covers.Wayne.text2
    cell.trackNameLabel.textColor = Color.Covers.Wayne.text1
    cell.trackTimeLabel.textColor = Color.Covers.Wayne.text2
    cell.moreButton.tintButtonColor(Color.Covers.Wayne.button)
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
