//
//  Constants.swift
//  github_uikit
//
//  Created by Venkatesham Boddula on 12/06/24.
//

import UIKit
/*
 Reasons to use enum instead of struct
 You can instantiate a struct to create instances, even if it only contains static properties.
 But you cannot instantiate an enum.
 */

enum GFSFSymbols {
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}

enum GFImages {
    static let ghLogo = UIImage(named: "gh-logo")
    static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
}

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    
    static let maxLength = max(width, height)
    static let minLength = min(width, height)
}

enum DeviceTypes {
    
    /*
     
     Logical coordinate space refers to the coordinate system used by UIKit for laying out and rendering UI elements. It is measured in points
     rather than pixels.
     Native coordinate space refers to the actual pixel dimensions of the device's screen. It measures the screen in terms of its physical
     pixels.
     
     UIScreen.main.scale --> returns the scale factor applied to the logical coordinate space of the screen.
     UIScreen.main.nativeScale --> returns the scale factor applied to the native coordinate space of the
     screen.
     
     scale values are typically rounded to the nearest whole number (1.0, 2.0, 3.0).
     nativeScale values can be more precise and vary based on the device's exact pixel density. (Ex: 2.608)
     */
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale
    
    static let isIphoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isIphone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isIphone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isIphone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale == scale
    static let isIphone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale > scale
    static let isIphoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isIphoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isIpad = idiom == .pad && ScreenSize.maxLength >= 1024.0    
}
