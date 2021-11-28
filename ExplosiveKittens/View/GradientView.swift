//
//  GradientView.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 27.11.2021.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    enum Direction {
        case top
        case bottom
        case left
        case right
        case sideDiagonal
    }
    
    var direction: Direction = .sideDiagonal {
        didSet {
            updateInterface()
        }
    }
    var colors: [UIColor] = [] {
        didSet {
            updateInterface()
        }
    }
    var locations: [NSNumber] = [] {
        didSet {
            updateInterface()
        }
    }
    
    override var frame: CGRect {
        didSet {
            gradientLayer.frame = bounds
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInterface()
    }
    
    // MARK: Interface
    
    func setupInterface() {
        backgroundColor = .clear
        updateInterface()
    }
    
    func updateInterface() {
        let cgColors = colors.compactMap({$0.cgColor})
        gradientLayer.colors = cgColors
        
        if gradientLayer.type == .axial {
            switch direction {
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            case .sideDiagonal:
                gradientLayer.startPoint = CGPoint(x: 0, y: 1)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            }
        } else if gradientLayer.type == .radial {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 2.0, y: 1.0)
        }
        
        gradientLayer.locations = locations
    }
}
