//
//  Localization.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 28.11.2021.
//

import Foundation


enum Localization {
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}

protocol LocalizedModuleNameSupportable {
    static var moduleName: String { get }
}

extension LocalizedModuleNameSupportable {
    static var moduleName: String {
        return String(describing: self)
    }
}
