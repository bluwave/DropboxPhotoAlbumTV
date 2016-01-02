xcodeproj 'DropboxPhotoAlbumTV/DropboxPhotoAlbumTV.xcodeproj'
use_frameworks!
workspace 'DropboxPhotoAlbumTV'

def common_pods
	platform :tvos, '9.0'
	# pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git'
	pod 'SDWebImage', :git => 'git@github.com:rs/SDWebImage.git', :inhibit_warnings => true
	pod 'XCGLogger', '~> 3.1'
	pod 'SwiftyDropbox', :git => git@github.com:bluwave/SwiftyDropbox.git, :branch => 'tvOS'
end

target 'DropboxPhotoAlbumTV', :exclusive => true do
	platform :tvos, '9.0'
    xcodeproj 'DropboxPhotoAlbumTV/DropboxPhotoAlbumTV'
    link_with 'DropboxPhotoAlbumTV'
	common_pods	
end
