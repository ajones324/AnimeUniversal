//
//  DuckduckgoService.swift
//  AnimeUniversal
//
//  Created by Andrew Ikenna Jones on 10/31/22.
//

import Foundation

protocol DuckduckgoService_Protocol {
    func searchCharacters(query: String, completion: @escaping (Result<[CharacterModel], Error>) -> Void)
    func searchSimpsons(completion: @escaping (Result<[CharacterModel], Error>) -> Void)
    func searchTheWire(completion: @escaping (Result<[CharacterModel], Error>) -> Void)
}

class DuckduckgoService: DuckduckgoService_Protocol {
    private let httpClient: HttpClient
    private let jsonDecoder: JSONDecoder
    
    enum DuckduckgoServiceError: Error {
        case invalidUrl
    }
    
    struct test: Codable {
        let type: String
    }

    init() {
        self.httpClient = HttpClient(session: URLSession.shared)
        self.jsonDecoder = JSONDecoder()
    }
    
    func searchSimpsons(completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        searchCharacters(query: "Simpsons Characters") { result in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchTheWire(completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        searchCharacters(query: "The Wire Characters") { result in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchCharacters(query: String, completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = DuckduckgoAPI.host
        let queryItem = URLQueryItem(name: "q", value: query)
        let formatItem = URLQueryItem(name: "format", value: "json")
        urlComponents.queryItems = [queryItem, formatItem]
        
        guard let url = urlComponents.url else {
            completion(.failure(DuckduckgoServiceError.invalidUrl))
            return
        }
                
        httpClient.get(url: url) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(HttpClientError.emptyData))
                return
            }
            do {
                let result = try self.jsonDecoder.decode(DuckduckgoSearchModel.self, from: data)
                completion(.success(result.relatedTopics ?? []))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

