//
//  UIStoryboard+Extensions.swift
//  DropboxPhotoAlbumTV
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 Garrett Richards. All rights reserved.
//

import UIKit

extension UIStoryboard {

    public static func viewControllerFromClass(indentifierClass: AnyClass) -> UIViewController? {
        let identifier = NSStringFromClass(indentifierClass)
        if let nonNameSpacedClassIdentifier = identifier.removeNameSpace() {
            return self.mainStoryboard().instantiateViewControllerWithIdentifier(nonNameSpacedClassIdentifier)
        }
        return nil
    }
    
    public static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}