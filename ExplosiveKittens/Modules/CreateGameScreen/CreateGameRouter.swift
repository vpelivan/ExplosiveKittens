//
//  CreateGameRouter.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 28.11.2021.
//


class CreateGameRouter: AnyRouter {
    func route(to destination: EntryPoint) {
        
    }
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = CreateGameRouter()
        
        var view: AnyView = CreateGameViewController()
        var presenter: AnyPresenter = CreateGamePresenter()
        var interactor: AnyInteractor = CreateGameInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
