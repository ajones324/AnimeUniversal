//
//  LocationItem.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 10/31/22.
//

import Foundation

struct DuckduckgoSearchModel: Codable {
    let heading : String?
    let abstractURL: String?
    let relatedTopics: [CharacterModel]?
    
    private enum CodingKeys : String, CodingKey {
        case heading = "Heading"
        case abstractURL = "AbstractURL"
        case relatedTopics = "RelatedTopics"
    }
}

struct CharacterModel: Codable {
    let firstURL: String?
    let icon: DuckduckgoIcon?
    let titleText: String?
    let detailText: String?
    
    private enum CodingKeys : String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case titleText = "Text"
        case detailText = "Result"
    }
    
    func characterName() -> String {
        let delimiter = " - "
        let separated = self.titleText?.components(separatedBy: delimiter)
        return separated?[0] ?? "Unknown"
    }
}

struct DuckduckgoIcon: Codable {
    let height: String?
    let width: String?
    let url: String?
    private enum CodingKeys : String, CodingKey {
        case height = "Height"
        case width = "Width"
        case url = "URL"
    }
}
