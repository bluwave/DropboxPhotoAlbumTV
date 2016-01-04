//
//  PhotoManager.swift
//  DropboxPhotoAlbumTV
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 bluwave. All rights reserved.
//

import Foundation
import SwiftyDropbox

public class PhotoManager {
    
    var client: DropboxClient
    
    public init(dropboxClient: DropboxClient) {
        client = dropboxClient
    }
    
    //  MARK: - Photos
    
    public func getPhotoURLsFromPath(path:String, completionHander:([String]) -> Void) {
        var results = [String]()
        client.files.listFolder(path: path).response { response, error in
            if let result = response {
                for file in result.entries {
                    if(file is Files.FileMetadata) {
                        if let fileMetaData = file as? Files.FileMetadata {
                            //                            print(fileMetaData)
                            if(self.isImage(fileMetaData.name)) {
                                results.append(fileMetaData.pathLower)
                            }
                        }
                    }
                }
            } else {
                Logger.error(error!.description)
            }
            completionHander(results)
        }
    }
    
    public func getImage(path: String, handler: (UIImage?) -> Void) {
        client.files.download(path: path, destination: self.defaultDestination(path)).response { response, error in
            //            if let (metadata, url) = response {
            //  TODO - check for error first to bypass this other stuff
            if let (_, url) = response {
                print("*** Download file ***")
                let data = NSData(contentsOfURL: url)
                var image:UIImage? = nil
                if let data = data {
                    image = UIImage(data:data)
                }
                handler(image)
                //                print("Downloaded file name: \(metadata.name)")
                //                print("Downloaded file url: \(url)")
                //                print("Downloaded file data: \(data)")
            } else {
                print(error!)
            }
        }
    }
    
    private func defaultDestination(path:String) -> (NSURL, NSHTTPURLResponse) -> NSURL {
        let destination : (NSURL, NSHTTPURLResponse) -> NSURL = { temporaryURL, response in
            let fileManager = NSFileManager.defaultManager()
            let directoryURL = fileManager.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
            Logger.debug(directoryURL.absoluteString)
            
            let suggestedFilename = path.lastPathComponent()
            //            if let name = response.name {
            //                suggestedFilename = name
            //            }
            Logger.debug("suggestedFilename: \(suggestedFilename)")
            
            return directoryURL.URLByAppendingPathComponent(suggestedFilename)
        }
        return destination
    }
    
    private func isImage(filename:String) -> Bool {
        let lastPathComponent = filename.pathExtension().lowercaseString
        return lastPathComponent == "jpg" || lastPathComponent == "png"
    }
}

