//
//  KayToolbar.swift
//  KayPhotoBrowser
//
//

import Foundation

// helpers which often used
private let bundle = Bundle(for: KayPhotoBrowser.self)

class KayToolbar: UIToolbar {
    var toolCounterLabel: UILabel!
    var toolCounterButton: UIBarButtonItem!
    var toolPreviousButton: UIBarButtonItem!
    var toolNextButton: UIBarButtonItem!
    var toolActionButton: UIBarButtonItem!
    
    fileprivate weak var browser: KayPhotoBrowser?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, browser: KayPhotoBrowser) {
        self.init(frame: frame)
        self.browser = browser
        
        setupApperance()
        setupPreviousButton()
        setupNextButton()
        setupCounterLabel()
        setupActionButton()
        setupToolbar()
    }
    
    func updateToolbar(_ currentPageIndex: Int) {
        guard let browser = browser else { return }
        
        if browser.numberOfPhotos > 1 {
            toolCounterLabel.text = "\(currentPageIndex + 1) / \(browser.numberOfPhotos)"
        } else {
            toolCounterLabel.text = nil
        }
        
        toolPreviousButton.isEnabled = (currentPageIndex > 0)
        toolNextButton.isEnabled = (currentPageIndex < browser.numberOfPhotos - 1)
    }
}

private extension KayToolbar {
    func setupApperance() {
        backgroundColor = UIColor.clear
        clipsToBounds = true
        isTranslucent = true
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        
        // toolbar
        if !KayPhotoBrowserOptions.displayToolbar {
            isHidden = true
        }
    }
    
    func setupToolbar() {
        guard let browser = browser else { return }
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        if browser.numberOfPhotos > 1 && KayPhotoBrowserOptions.displayBackAndForwardButton {
            items.append(toolPreviousButton)
        }
        if KayPhotoBrowserOptions.displayCounterLabel {
            items.append(flexSpace)
            items.append(toolCounterButton)
            items.append(flexSpace)
        } else {
            items.append(flexSpace)
        }
        if browser.numberOfPhotos > 1 && KayPhotoBrowserOptions.displayBackAndForwardButton {
            items.append(toolNextButton)
        }
        items.append(flexSpace)
        if KayPhotoBrowserOptions.displayAction {
            items.append(toolActionButton)
        }
        setItems(items, animated: false)
    }
    
    func setupPreviousButton() {
        let previousBtn = KayPreviousButton(frame: frame)
        previousBtn.addTarget(browser, action: #selector(KayPhotoBrowser.gotoPreviousPage), for: .touchUpInside)
        toolPreviousButton = UIBarButtonItem(customView: previousBtn)
    }
    
    func setupNextButton() {
        let nextBtn = KayNextButton(frame: frame)
        nextBtn.addTarget(browser, action: #selector(KayPhotoBrowser.gotoNextPage), for: .touchUpInside)
        toolNextButton = UIBarButtonItem(customView: nextBtn)
    }
    
    func setupCounterLabel() {
        toolCounterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 95, height: 40))
        toolCounterLabel.textAlignment = .center
        toolCounterLabel.backgroundColor = UIColor.clear
        toolCounterLabel.font  = UIFont(name: "Helvetica", size: 16.0)
        toolCounterLabel.textColor = UIColor.white
        toolCounterLabel.shadowColor = UIColor.black
        toolCounterLabel.shadowOffset = CGSize(width: 0.0, height: 1.0)
        toolCounterButton = UIBarButtonItem(customView: toolCounterLabel)
    }
    
    func setupActionButton() {
        toolActionButton = UIBarButtonItem(barButtonSystemItem: .action, target: browser, action: #selector(KayPhotoBrowser.actionButtonPressed))
        toolActionButton.tintColor = UIColor.white
    }
}


class KayToolbarButton: UIButton {
    let insets: UIEdgeInsets = UIEdgeInsets(top: 13.25, left: 17.25, bottom: 13.25, right: 17.25)
    
    func setup(_ imageName: String) {
        backgroundColor = UIColor.clear
        imageEdgeInsets = insets
        translatesAutoresizingMaskIntoConstraints = true
        autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        contentMode = .center
        
        let image = UIImage(named: "KayPhotoBrowser.bundle/images/\(imageName)",
                            in: bundle, compatibleWith: nil) ?? UIImage()
        setImage(image, for: UIControlState())
    }
}

class KayPreviousButton: KayToolbarButton {
    let imageName = "btn_common_back_wh"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        setup(imageName)
    }
}

class KayNextButton: KayToolbarButton {
    let imageName = "btn_common_forward_wh"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        setup(imageName)
    }
}
