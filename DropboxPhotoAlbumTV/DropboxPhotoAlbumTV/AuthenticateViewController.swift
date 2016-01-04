//
//  AuthenticateViewController.swift
//  DropboxPhotoAlbumTV
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 bluwave. All rights reserved.
//

import UIKit
import SwiftyDropbox
import TVOAuthCircumventAssistant

class AuthenticateViewController: UIViewController {

    @IBOutlet weak var URLLabel: UILabel!
    private var assistant: TVOAuthCircumventAssistant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAssistant()
    }
    
    private func configureAssistant() {
        
        var configuration = TVOAuthCircumventAssistantConfiguration()
        configuration.tvTokenFetchURL = Constants.LocalConfigurations.instance.tvTokenFetchURL()
        configuration.retrieveAuthenticationInfoURL = configuration.tvTokenFetchURL
        
        assistant = TVOAuthCircumventAssistant(configuration: configuration)
        assistant?.fetchTVToken({ [weak self] (response, error) -> Void in
            if let response = response {
                Logger.debug("\(response)")
                self?.URLLabel.text = response[Constants.OAuthHelperAPI.JSONKeys.URL] as? String
                if let tvToken = response[Constants.OAuthHelperAPI.JSONKeys.tvToken] {
                    self?.assistant?.configuration.retrieveAuthenticationInfoURL = (self?.assistant?.configuration.retrieveAuthenticationInfoURL)! + "/\(tvToken)"
                }
            } else if let error = error as? NSError {
                self?.URLLabel.text = error.localizedDescription
                Logger.error(error)
            }
        })
    }

    private func retrieveOAuthAuthenticationInfo() {
        assistant?.retrieveAuthenticationInfoURL({ [weak self] (response, error) -> Void in
            if let response = response {
                let accessToken = response[Constants.OAuthHelperAPI.JSONKeys.DropboxAccessToken] as? String
                let userID = response[Constants.OAuthHelperAPI.JSONKeys.userID] as? String
                self?.authenticateToDropbox(accessToken, userID: userID)
            } else if let error = error as? NSError {
                //  TODO - need error popup
                Logger.error(error)
            }
        })
    }

    //  MARK: - Helpers

    private func authenticateToDropbox(accessToken: String?, userID: String?) {
        guard let accessToken = accessToken, userID = userID else  {
            Logger.error("\(__FUNCTION__) Error: missing accessToken or userID")
            return
        }
        Dropbox.authorizeWithAccessToken(DropboxAccessToken(accessToken: accessToken, uid: userID))
    }

    //  MARK: - Actions
    
    @IBAction func actionAuthenticationCompleted(sender: AnyObject) {
        retrieveOAuthAuthenticationInfo()
    }

}
