//
//  SearchViewController.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 10/31/22.
//

import UIKit
import Combine

protocol SearchViewControllerDelegate: AnyObject {
    func didSelectCharacter(_ character: CharacterModel)
}

class SearchViewController: UIViewController {

    private var viewModel: SearchViewModel = SearchViewModel()
    private var cancellables: Set<AnyCancellable> = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
        prepareView()
        viewModel.viewDidLoad()
    }
    
    private func prepareView() {
        self.title = viewModel.title
        self.searchBar.searchTextField.autocapitalizationType = .words
        self.searchBar.returnKeyType = .search
    }
    
    private func bindViewModel() {
        viewModel.$characters
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                    self?.updateCharacters()
            }
            .store(in: &cancellables)
        
        viewModel.$title
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.title = self?.viewModel.title
            }
            .store(in: &cancellables)
    }
    
    private func updateCharacters() {
        self.tableView.reloadData()
    }
}

// MARK: UISearchBarDelegate Methods
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            if text.isEmpty {
                viewModel.didSearchBarEmpty()
            } else {
                viewModel.filterCharacters(query: text)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text,
           !query.isEmpty {
            viewModel.filterCharacters(query: query)
            searchBar.resignFirstResponder()
        }
    }
}

// MARK: TableViewDataSource, TableViewDelegate Methods
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let characterCell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        let character = viewModel.characters[indexPath.row]
        characterCell.textLabel?.text = character.characterName()
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selected = viewModel.characters[indexPath.row]
        self.delegate?.didSelectCharacter(selected)
    }
}

