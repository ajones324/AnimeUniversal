//
//  CharacterDetailView.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 10/31/22.
//

import UIKit
import SafariServices

class CharacterDetailView: UIView {
    var model: CharacterModel? {
        didSet {
            self.detailTextLabel.text = model?.titleText
            if model?.firstURL != nil {
                linkButton.isHidden = false
            }
            
            if let urlString = model?.icon?.url,
               let imageURL = URL(string: urlString) {
                imageView.loadImageURL(url: imageURL)
            }
        }
    }
    
    let linkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("More Detail", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.isHidden = true
        return button
    }()
    
    let detailTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [detailTextLabel, linkButton, imageView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
