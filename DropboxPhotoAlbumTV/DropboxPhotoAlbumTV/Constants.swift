//
//  Constants.swift
//  DropboxPhotoAlbumTV
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 Garrett Richards. All rights reserved.
//

import Foundation

struct Constants {

    struct OAuthHelperAPI {

        struct JSONKeys {
            static let URL = "url"
            static let tvToken = "tv_token"
            static let DropboxAccessToken = "db_access_token"
            static let userID = "user_id"
        }
    }
    
    struct LocalConfigurations {
        private var keyValues = [String:AnyObject]()
        static let instance = LocalConfigurations()
        private struct keys {
            static let dropboxAppKey = "dropboxAppKey"
            static let tvTokenFetchURL = "tvTokenFetchURL"
        }
        private init() {
            if let path = NSBundle.mainBundle().pathForResource("LocalConfigurations", ofType: "plist") {
                if let plist = NSDictionary(contentsOfFile: path) as? [String:AnyObject] {
                    keyValues = plist
                }
            }
        }

        func tvTokenFetchURL() ->String {
            return (keyValues[keys.tvTokenFetchURL] as? String) ?? ""
        }
        func dropboxAppKey() -> String {
            return (keyValues[keys.dropboxAppKey] as? String) ?? ""
        }
    }
}
