//
//  StnDetectingView.swift
//  StnPhotoBrowser
//
//

import UIKit

@objc protocol StnDetectingViewDelegate {
    func handleSingleTap(_ view: UIView, touch: UITouch)
    func handleDoubleTap(_ view: UIView, touch: UITouch)
}

class StnDetectingView: UIView {
    weak var delegate: StnDetectingViewDelegate?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        defer {
            _ = next
        }
        
        guard let touch = touches.first else {
            return
        }
        switch touch.tapCount {
        case 1 : handleSingleTap(touch)
        case 2 : handleDoubleTap(touch)
        default: break
        }
    }
    
    func handleSingleTap(_ touch: UITouch) {
        delegate?.handleSingleTap(self, touch: touch)
    }
    
    func handleDoubleTap(_ touch: UITouch) {
        delegate?.handleDoubleTap(self, touch: touch)
    }
}
