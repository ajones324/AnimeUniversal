//
//  SearchViewModel.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 10/31/22.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    let apiService: DuckduckgoService
    private var allCharacters: [CharacterModel] = []
    @Published private(set) var characters: [CharacterModel] = []
    @Published private(set) var title: String?

    init(model:[CharacterModel]? = nil, title: String? = "Search") {
        if let model = model {
            self.characters = model
        }
        self.apiService = DuckduckgoService()
        self.title = title
    }
}

extension SearchViewModel {
    
    func viewDidLoad() {
        fetchSimpsonsCharacters()
    }
    
    func filterCharacters(query: String) {
        self.characters = allCharacters.filter{($0.titleText?.lowercased().contains(query.lowercased()) ?? false) || ($0.detailText?.lowercased().contains(query.lowercased()) ?? false)}
    }
    
    private func fetchSimpsonsCharacters() {
        self.title = "Simpsons"
        self.apiService.searchSimpsons { result in
            switch result {
            case .success(let characters):
                self.allCharacters = characters
                self.characters = characters
            case .failure(_):
                return
            }
        }
    }
    
    private func fetchTheWireCharacters() {
        self.title = "The Wire"
        self.apiService.searchTheWire { result in
            switch result {
            case .success(let characters):
                self.allCharacters = characters
                self.characters = characters
            case .failure(_):
                return
            }
        }
    }
    
    func clearCharacters() {
        characters.removeAll()
    }
    
    func didSearchBarEmpty() {
        self.characters = self.allCharacters
    }
}
