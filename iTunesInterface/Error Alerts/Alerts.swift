//
//  Alerts.swift
//  iTunesInterface
//
//  Created by vamsi krishna reddy kamjula on 10/18/17.
//  Copyright © 2017 kvkr. All rights reserved.
//

import UIKit

extension UIViewController {
    func somethingWentWrongAlert() {
        let alert = UIAlertController.init(title: "Something Went Wrong !!!", message: "Try Again", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchTextErrorAlert() {
        let alert = UIAlertController.init(title: "Enter album name !!!", message: "Try Again", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
