//
//  URLSessionAdapter.swift
//  GitHubUserInfo
//
//  Created by Telman Yusifov on 17.05.25.
//

import Foundation

class URLSessionAdapter: APIService {
    func getUserData(username: String, completion: @escaping (Result<GithubUser, NetworkError>) -> ()) {
        let request = requestBuilder(url: "https://api.github.com/users/\(username)")
        if let request = request {
            taskBuilder(request: request, completion: completion)
        }
    }
    
    func taskBuilder<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Something went wrong while getting data:", error.localizedDescription)
                completion(.failure(.init(message: error.localizedDescription)))
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if let data = data {
                do {
                    if (200...300).contains(statusCode) {
                        let dataResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(dataResponse))
                    } else {
                        let dataResponse = try JSONDecoder().decode(NetworkError.self, from: data)
                        completion(.failure(dataResponse))
                    }
                } catch {
                    print("Something went wrong in decoding: \(error.localizedDescription)")
                    completion(.failure(.init(message: error.localizedDescription)))
                }
            }
        }
        task.resume()
    }
    
    func requestBuilder(url: String) -> URLRequest? {
        let url = URL(string: url)
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        }
        return nil
    }
}

struct NetworkError: Decodable, Error {
    let message: String
//    let status: String
}
