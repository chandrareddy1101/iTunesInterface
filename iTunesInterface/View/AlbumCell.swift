//
//  AlbumCell.swift
//  iTunesInterface
//
//  Created by vamsi krishna reddy kamjula on 10/18/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var albumTitleLbl: UILabel!
    @IBOutlet weak var albumCoverImgView: UIImageView!
    
    func configureCell(_ albumDetails: Album) {
        self.layer.cornerRadius = 7
        albumTitleLbl.text = albumDetails.name
        albumCoverImgView.image = albumDetails.coverImage
    }
}
