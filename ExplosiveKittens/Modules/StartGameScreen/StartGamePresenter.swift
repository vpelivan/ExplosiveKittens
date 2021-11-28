//
//  StartGamePresenter.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 23.11.2021.
//


class StartGamePresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor?
    var view: AnyView?
    
    func createGame() {
        let createGameRouter = CreateGameRouter.start()
        guard let initialViewController = createGameRouter.entry else {
            return
        }
        router?.route(to: initialViewController)
    }
    
}
