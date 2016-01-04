xcodeproj 'DropboxPhotoAlbumTV/DropboxPhotoAlbumTV.xcodeproj'
use_frameworks!
workspace 'DropboxPhotoAlbumTV'

target 'DropboxPhotoAlbumTV', :exclusive => true do
	platform :tvos, '9.0'
    xcodeproj 'DropboxPhotoAlbumTV/DropboxPhotoAlbumTV'
    link_with 'DropboxPhotoAlbumTV'
	pod 'SDWebImage', :git => 'git@github.com:rs/SDWebImage.git', :inhibit_warnings => true
	pod 'XCGLogger', '~> 3.1'
	pod 'SwiftyDropbox', :git => 'git@github.com:bluwave/SwiftyDropbox.git', :branch => 'tvOS'
	pod 'TVOAuthCircumventAssistant', :git => 'git@github.com:bluwave/TVOAuthCircumventAssistant.git'
    # pod 'TVOAuthCircumventAssistant', :path => '~/src3/dropboxPhotos/TVOAuthCircumventAssistant/TVOAuthCircumventAssistant'
end
