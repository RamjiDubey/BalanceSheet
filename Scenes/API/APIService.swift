//
//  APIService.swift
//  BalanceSheet
//
//  Created by RAM JI DUBEY.
//

import Combine
import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchUsers() -> AnyPublisher<[DummyDataResponse], Error> {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [DummyDataResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
