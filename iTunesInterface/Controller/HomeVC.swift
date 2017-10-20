//
//  ViewController.swift
//  iTunesInterface
//
//  Created by vamsi krishna reddy kamjula on 10/18/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit
import Alamofire

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var searchBarTxt: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBarTxt.delegate = self
        
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        self.getAlbums(GET_NEW_RELEASES_URL)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBarTxt.text, searchBarTxt.text != "" else {
            self.searchTextErrorAlert()
            return
        }
        let searchTerm = searchText.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://api.spotify.com/v1/search?q=\(searchTerm)&type=album&market=US&limit=20"
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        self.getAlbums(urlString)
    }
    
    func getAlbums(_ url: String) {
        DataService.instance.getMusicData(urlString: url) { (success) in
            if success {
                self.activitySpinner.isHidden = true
                self.activitySpinner.stopAnimating()
                self.collectionView.reloadData()
            } else {
                self.somethingWentWrongAlert()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.albumDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ALBUM_CELL_IDENTIFIER, for: indexPath) as? AlbumCell {
            let video = DataService.instance.albumDetails[indexPath.row]
            cell.configureCell(video)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numOfColumns : CGFloat = 3
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 5
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        return CGSize(width: cellDimension, height: cellDimension * 1.3)
    }
}
