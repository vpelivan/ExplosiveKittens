//
//  AnyInteractor.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 27.11.2021.
//


protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
}
