//
//  UIFont.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 28.11.2021.
//

import UIKit

enum Font: String {
    case dinCondensed = "DIN Condensed"
}

extension UIFont {
    static func custom(font family: Font, weight: UIFont.Weight, size: CGFloat) -> UIFont {
        var fontTraits = [UIFontDescriptor.TraitKey: Any]()
        
        fontTraits[.weight] = weight
        
        let fontDescriptor = UIFontDescriptor(
            fontAttributes: [
                .family: family.rawValue,
                .traits: fontTraits
            ]
        )
        return UIFont(descriptor: fontDescriptor, size: size)
    }
}
