//
//  CharacterDetailViewModel.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 10/31/22.
//

import Foundation

class CharacterDetailViewModel {
    // MARK: - Initialization
    init(model: CharacterModel? = nil) {
        self.character = model
    }
    var character: CharacterModel?
}
