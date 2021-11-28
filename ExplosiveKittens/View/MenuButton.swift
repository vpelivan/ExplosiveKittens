//
//  MenuButton.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 27.11.2021.
//

import Foundation
import UIKit

class MenuButton: UIButton {
    
    private enum Constants {
        enum Colors {
            static let black: CGColor = UIColor.black.cgColor
            static let white: CGColor = UIColor.white.cgColor
            static let titleGradient: UIColor = .orangeRedGradient
        }
        
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 1.5
        static let shadowOffset: CGSize = .init(width: 2.0, height: 2.0)
        static let shadowOpacity: Float = 0.5
        
        enum MenuButtonAttributes {
            static let font: UIFont = .custom(font: .dinCondensed, weight: .bold, size: 22.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMenuButtonAppearence()
        self.isUserInteractionEnabled = true
    }
    
    private func setupMenuButtonAppearence() {
        backgroundColor = UIColor.black
        layer.shadowColor = Constants.Colors.black
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowOpacity = Constants.shadowOpacity
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = Constants.Colors.white
    }
    
    func setButtonTitle(title: String) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.MenuButtonAttributes.font,
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedString, for: .normal)
        setTitleColor(Constants.Colors.titleGradient, for: .normal)
    }
    
}
