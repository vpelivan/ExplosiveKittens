//
//  AnyPresenter.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 27.11.2021.
//


protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func createGame()
}
