//
//  SplitViewController.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 4/24/23.
//

import UIKit

class SplitViewController: UISplitViewController {

    private var primaryViewController: SearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadViewControllers()
    }
    
    private func loadViewControllers() {
        let searchVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchViewController
        self.primaryViewController = searchVC
        self.primaryViewController.delegate = self
        let navController = UINavigationController(rootViewController: self.primaryViewController)
        
        let detailVC = CharacterDetailViewController(viewModel: CharacterDetailViewModel())
        
        self.viewControllers = [navController, detailVC]
    }
}

extension SplitViewController: SearchViewControllerDelegate {
    func didSelectCharacter(_ character: CharacterModel) {
        let detailVC = CharacterDetailViewController(viewModel: CharacterDetailViewModel(model: character))
        self.showDetailViewController(detailVC, sender: nil)
    }
}
