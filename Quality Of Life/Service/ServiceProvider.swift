//
//  ServiceProvider.swift
//  Quality Of Life
//
//  Created by Dan Mori on 05/07/22.
//

import Foundation

protocol ServiceProvider {
    func getMostPopulatedCities(completion: @escaping((Result<MostPopulatedCitiesResponse, APIError>) -> Void))
}

class ServiceAPI: ServiceProvider {
    private let baseURL = "https://api.teleport.org/api/"
    
    private enum Endpoint: String {
        case mostPopulatedCities = "/cities/"
    }
    
    private enum Method: String {
        case GET
        case POST
        case DELETE
    }
    
    func getMostPopulatedCities(completion: @escaping ((Result<MostPopulatedCitiesResponse, APIError>) -> Void)) {
        request(withEndpoint: .mostPopulatedCities, method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(withEndpoint endpoint: Endpoint, method: Method, completion: @escaping ((Result<T, APIError>) -> Void)) {
        let path = "\(baseURL)\(endpoint.rawValue)"
        guard let url = URL(string: path) else { completion(.failure(.internalError)); return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Tyoe": "application/json"]
        
        call(withRequest: request, completion: completion)
    }
    
    private func call<T: Codable>(withRequest request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { completion(.failure(.serverError)); return }
            do {
                guard let data = data else { completion(.failure(.serverError)); return }
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}
