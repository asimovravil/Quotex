//
//  NewsApi.swift
//  Quotex
//
//  Created by Ravil on 19.10.2023.
//

import Foundation

class NewsAPI {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=1a253477eb7e4ba68a9e284d67ebc825"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let articleResponse = try decoder.decode(ArticleResponse.self, from: data)
                
                completion(.success(articleResponse.articles))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
