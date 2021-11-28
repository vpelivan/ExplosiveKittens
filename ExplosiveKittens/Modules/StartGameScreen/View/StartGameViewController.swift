//
//  StartGameViewController.swift
//  ExplosiveKittens
//
//  Created by Victor Pelivan on 23.11.2021.
//

import UIKit

class StartGameViewController: UIViewController, AnyView {
    
    private enum Constants {
        
        enum Gradient {
            static let innerColor: UIColor = .lightRed
            static let outerColor: UIColor = .darkRed
            static let locations: [NSNumber] = [0.0, 2.0]
        }
    }
    
    var presenter: AnyPresenter?
    
    @IBOutlet private weak var gradientView: GradientView!
    @IBOutlet private weak var createGameButton: MenuButton!
    @IBOutlet private weak var joinGameButton: MenuButton!
    @IBOutlet private weak var settingsButton: MenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupButtons()
    }
    
    private func setupGradient() {
        gradientView.gradientLayer.type = .radial
        gradientView.colors = [Constants.Gradient.innerColor, Constants.Gradient.outerColor]
        gradientView.locations = Constants.Gradient.locations
    }
    
    private func setupButtons() {
        createGameButton.setButtonTitle(title: Localization.StartGame.createGame)
        joinGameButton.setButtonTitle(title: Localization.StartGame.joinGame)
        settingsButton.setButtonTitle(title: Localization.StartGame.gameSettings)
    }
    
    @IBAction func createGame(_ sender: Any) {
        presenter?.createGame()
    }
}
