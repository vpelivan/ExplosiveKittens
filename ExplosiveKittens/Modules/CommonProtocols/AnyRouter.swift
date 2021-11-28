//
//  AnyRouter.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 27.11.2021.
//

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouter
    func route(to destination: EntryPoint)
}
