//
//  StnButtons.swift
//  StnPhotoBrowser
//
//  Created by 鈴木 啓司 on 2016/08/09.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import Foundation

// helpers which often used
private let bundle = Bundle(for: StnPhotoBrowser.self)

class StnButton: UIButton {
    var showFrame: CGRect!
    var hideFrame: CGRect!
    var insets: UIEdgeInsets {


        return UI_USER_INTERFACE_IDIOM() == .phone
            ?  UIEdgeInsets(top: 15.25, left: 15.25, bottom: 15.25, right: 15.25) : UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    var size: CGSize = CGSize(width: 44, height: 44)
    var margin: CGFloat = 5
    
    var buttonTopOffset: CGFloat { return 5 }
    
    func setup(_ imageName: String) {
        backgroundColor = UIColor.clear
        imageEdgeInsets = insets
        //        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = true
        autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        //        let image = UIImage(named: imageName,
        //                            in: bundle, compatibleWith: nil) ?? UIImage()
        //let image = UIImage(named: imageName)
        //  setImage(image, for: UIControlState())
        titleLabel?.font = UIFont(name: "FontAwesome", size: 24)
        setTitle("", for: UIControlState())
    }
  
    func updateFrame() { }
  
    func setFrameSize(_ size: CGSize) {
        let newRect = CGRect(x: margin, y: buttonTopOffset, width: size.width, height: size.height)
        self.frame = newRect
        showFrame = newRect
        hideFrame = CGRect(x: margin, y: -20, width: size.width, height: size.height)
    }
}

class StnCloseButton: StnButton {
    let imageName = "btn_common_close_wh"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(imageName)
        showFrame = CGRect(x: margin, y: buttonTopOffset, width: size.width, height: size.height)
        hideFrame = CGRect(x: margin, y: -20, width: size.width, height: size.height)
    }
    
    override func updateFrame() {
    }
}

class StnDeleteButton: StnButton {
    let imageName = "btn_common_delete_wh"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(imageName)
        showFrame = CGRect(x: StnMesurement.screenWidth - size.width, y: buttonTopOffset, width: size.width, height: size.height)
        hideFrame = CGRect(x: StnMesurement.screenWidth - size.width, y: -20, width: size.width, height: size.height)
    }
    
    override func updateFrame() {
    }
  
    override func setFrameSize(_ size: CGSize) {
        let newRect = CGRect(x: StnMesurement.screenWidth - size.width, y: buttonTopOffset, width: size.width, height: size.height)
        self.frame = newRect
        showFrame = newRect
        hideFrame = CGRect(x: StnMesurement.screenWidth - size.width, y: -20, width: size.width, height: size.height)
    }
}