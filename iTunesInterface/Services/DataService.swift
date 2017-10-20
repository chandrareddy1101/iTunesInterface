//
//  DataService.swift
//  iTunesInterface
//
//  Created by vamsi krishna reddy kamjula on 10/18/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    static let instance = DataService()
    
    var albumDetails = [Album]()
    
    func getMusicData(urlString: String, completion:@escaping CompletionHandler) {
        let url = URL(string: urlString)
        self.albumDetails.removeAll()
        Alamofire.request(url!, method: .get, parameters: ["q":"Justin Timberlake", "type": "track"], encoding: URLEncoding.default, headers: ["Authorization": "Bearer "+OAuthToken]).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let albums = json["albums"].dictionary else {
                    completion(false)
                    return
                }
                guard let items = albums["items"]?.arrayValue else {
                    completion(false)
                    return
                }
                for item in items {
                    let albumId = item["id"].stringValue
                    let albumName = item["name"].stringValue
                    guard let images = item["images"].array else {
                        completion(true)
                        return
                    }
                    let urlString = images[1]["url"].stringValue
                    let url = URL(string: urlString)
                    let imageData = NSData(contentsOf: url!)
                    let albumImage = UIImage(data: imageData! as Data)
                    
                    let album = Album(id: albumId, name: albumName, coverImage: albumImage)
                    self.albumDetails.append(album)
                }
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
}
