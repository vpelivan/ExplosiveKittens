//
//  StartGameRouter.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 23.11.2021.
//

import UIKit

class StartGameRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = StartGameRouter()
        
        var view: AnyView = StartGameViewController()
        var presenter: AnyPresenter = StartGamePresenter()
        var interactor: AnyInteractor = StartGameInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func route(to destination: EntryPoint) {
        entry?.present(destination, animated: true, completion: nil)
    }
}
