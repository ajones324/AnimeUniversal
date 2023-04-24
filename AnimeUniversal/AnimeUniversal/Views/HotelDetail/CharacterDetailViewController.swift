//
//  CharacterDetailViewController.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 10/31/22.
//

import UIKit
import SafariServices

class CharacterDetailViewController: UIViewController {

    private let viewModel: CharacterDetailViewModel
    lazy var detailView = CharacterDetailView()
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    private func initialSetup() {
        detailView.model = viewModel.character
        self.title = viewModel.character?.characterName()
        detailView.linkButton.addTarget(self, action: #selector(didTapMoreDetailLink(_ :)), for: .touchUpInside)
    }
    
    @objc func didTapMoreDetailLink(_ sender: UIButton) {
        if let urlString = viewModel.character?.firstURL,
           let detailLink = URL(string: urlString) {
            let detailVC = SFSafariViewController(url: detailLink)
            self.present(detailVC, animated: true)
        }
    }
}
