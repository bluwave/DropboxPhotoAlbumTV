//
//  ViewController.swift
//  DropboxPhotoAlbumTV
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 bluwave. All rights reserved.
//

import UIKit
import SwiftyDropbox

class ViewController: UIViewController {
    
    private var images: [String]?
    private var photoMediaManager:PhotoManager?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePhotoManager()
        getUserInfo()
        getImages()
    }

    //  MARK: - configure
    
    private func configurePhotoManager() {
        if let client = Dropbox.authorizedClient {
            photoMediaManager = PhotoManager(dropboxClient: client)
        }
    }

    private func getUserInfo() {
        if let client = Dropbox.authorizedClient {
            client.users.getCurrentAccount().response { response, error in
                print("*** Get current account ***")
                if let account = response {
                    print("Hello \(account.name.givenName)!")
                } else {
                    print(error!)
                }
            }
        }
        else {
            print("no dropbox client")
        }
    }
    
    private func getImages() {
        photoMediaManager?.getPhotoURLsFromPath("/Camera Uploads") { [weak self] (images:[String]) -> Void  in
            print("fetched \(images.count) image urls")
            self?.images = images
            self?.nextImage()
        }
    }

    private func nextImage() {
        let randomPhotoPath = images?.randomItem()
        if let path = randomPhotoPath {
            photoMediaManager?.getImage(path, handler: { [weak self] (image) -> Void in
                self?.imageView.image = image
            })
        }
    }

    //  TODO - figure this all out (remote button presses)
    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        super.pressesBegan(presses, withEvent: event)
        for press in presses {
            switch (press.type) {
            case .PlayPause:
                nextImage()
                break
                //            case .UpArrow:
                //            case .DownArrow:
                //            case .LeftArrow:
                //            case .RightArrow:
                //            case .Select:
                //            case .Menu:
                //            case .PlayPause:
                //                break
            default:
                break
            }
        }
    }
}

