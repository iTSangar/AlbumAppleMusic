//
//  AlbumSupport.swift
//  AlbumTableView
//
//  Created by Ítalo Sangar on 2/24/16.
//  Copyright © 2016 iTSangar. All rights reserved.
//

import UIKit
import Reusable
import ChameleonFramework

protocol AlbumButtonCellDelegate {
  func actionTrackCellTapped(cell: TrackTableCell)
  func actionInfoCellTapped(cell: InfoTableCell, type: InfoButtonType)
  func actionAlbumCellTapped(cell: MoreAlbumCell, type: AlbumButtonType)
}

class TrackTableCell: UITableViewCell, Reusable {
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var trackNumberLabel: UILabel!
  @IBOutlet weak var trackTimeLabel: UILabel!
  @IBOutlet weak var moreButton: UIButton!
  
  var delegate: AlbumButtonCellDelegate?
  
  @IBAction func buttonTap(sender: UIButton) {
    if let delegate = self.delegate {
      delegate.actionTrackCellTapped(self)
    }
  }
  
  func configCellColor() {
    backgroundColor = Color.Covers.Krit.background
    trackNumberLabel.textColor = Color.Covers.Krit.subtext
    trackNameLabel.textColor = Color.Covers.Krit.text
    trackTimeLabel.textColor = Color.Covers.Krit.subtext
    moreButton.tintButtonColor(Color.Covers.Krit.button)
  }
}


enum InfoButtonType: Int {
  case Share = 1
  case Playlist
  case Comments
}

class InfoTableCell: UITableViewCell, Reusable {
  @IBOutlet var gradientBackground: UIView!
  @IBOutlet var commentsButton: UIButton!
  @IBOutlet var playlistButton: UIButton!
  @IBOutlet var shareButton: UIButton!
  @IBOutlet var commentImage: UIImageView!
  @IBOutlet var playImage: UIImageView!
  @IBOutlet var likeImage: UIImageView!
  @IBOutlet var albumName: UILabel!
  @IBOutlet var artistName: UILabel!
  @IBOutlet var countPlay: UILabel!
  @IBOutlet var countLike: UILabel!
  @IBOutlet var countComment: UILabel!
  
  var delegate: AlbumButtonCellDelegate?
  
  @IBAction func buttonTap(sender: UIButton) {
    if let delegate = self.delegate {
      delegate.actionInfoCellTapped(self, type: InfoButtonType(rawValue: sender.tag)!)
    }
  }
  
  func configCellColor() {
    gradientBackground.backgroundColor = GradientColor(.TopToBottom, frame: gradientBackground.frame,
      colors: [UIColor.clearColor(), Color.Covers.Krit.background, Color.Covers.Krit.background, Color.Covers.Krit.background])
    albumName.textColor = Color.Covers.Krit.text
    artistName.textColor = Color.Covers.Krit.text
    countPlay.textColor = Color.Covers.Krit.text
    countLike.textColor = Color.Covers.Krit.text
    countComment.textColor = Color.Covers.Krit.text
    likeImage.tintImageColor(Color.Covers.Krit.button)
    playImage.tintImageColor(Color.Covers.Krit.button)
    commentImage.tintImageColor(Color.Covers.Krit.button)
    shareButton.tintButtonColor(Color.Covers.Krit.button)
    playlistButton.tintButtonColor(Color.Covers.Krit.button)
    commentsButton.tintButtonColor(Color.Covers.Krit.button)
  }
}


enum AlbumButtonType: Int {
  case MoreBy = 1
  case Cover1
  case Cover2
  case Cover3
}

class MoreAlbumCell: UITableViewCell, Reusable {
  @IBOutlet var moreBy: UIButton!
  @IBOutlet var cover1: UIButton!
  @IBOutlet var cover2: UIButton!
  @IBOutlet var cover3: UIButton!
  @IBOutlet var albumName1: UILabel!
  @IBOutlet var albumName2: UILabel!
  @IBOutlet var albumName3: UILabel!
  
  var delegate: AlbumButtonCellDelegate?
  
  @IBAction func buttonTap(sender: UIButton) {
    if let delegate = self.delegate {
      delegate.actionAlbumCellTapped(self, type: AlbumButtonType(rawValue: sender.tag)!)
    }
  }
  
  func configCellColor() {
    backgroundColor = Color.Covers.Krit.background
    moreBy.titleLabel?.textColor = Color.Covers.Krit.text
    albumName1.textColor = Color.Covers.Krit.text
    albumName2.textColor = Color.Covers.Krit.text
    albumName3.textColor = Color.Covers.Krit.text
  }
}
