//
//  CustomControl.swift
//  StarRating
//
//  Created by Chris Price on 4/16/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {
    var value: Int = 1
    var labelArray: [UILabel] = []
    
    let componentDimension: CGFloat = 40.0
    let componentCount = 5
    let componentActiveColor = UIColor.black
    let componentInactiveColor = UIColor.gray
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setUp()
    }

    private func setUp() {
        for index in 1...5 {
            let label = UILabel()
            addSubview(label)
            labelArray.append(label)
            label.tag = index
            label.frame = CGRect(x: componentDimension + CGFloat(index * 28), y: 0.0, width: componentDimension, height: componentDimension)
            label.text = "✯" // Control + Command + Space for emoji keyboard
            label.font = UIFont(name: "systemBold", size: 32)
            label.textAlignment = .center
            if label.tag == 1 {
                //active color
            } else {
                //inactive color
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
      let componentsWidth = CGFloat(componentCount) * componentDimension
      let componentsSpacing = CGFloat(componentCount + 1) * 8.0
      let width = componentsWidth + componentsSpacing
      return CGSize(width: width, height: componentDimension)
    }

}

// MARK: - Touch Controls
extension CustomControl {
    
    func updateValue(at touch: UITouch) {
        
        let touchPoint = touch.location(in: self)
        
        for starLabel in labelArray {
            if starLabel.frame.contains(touchPoint) {
                value = starLabel.tag
                sendActions(for: .valueChanged)
            
                for starLabel in labelArray {
                    if starLabel.tag <= value {
                        starLabel.textColor = componentActiveColor
                        performFlare()
                    } else {
                        starLabel.textColor = componentInactiveColor
                    }
                }
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        updateValue(at: touch)
        
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            updateValue(at: touch)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: .touchDragOutside)
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        defer { super.endTracking(touch, with: event) }
        
        guard let touchPoint = touch?.location(in: self) else { return }
        
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: .touchUpOutside)
        }
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        
        sendActions(for: [.touchCancel])
    }
}

extension UIView {
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
