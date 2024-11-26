//
//  APIService.swift
//  testAstro
//
//  Created by Hemant on 26/11/24.
//

import Foundation


class MovieService {
    
    func fetchMovieData(completion: @escaping ([MovieData]?) -> Void) {
        let urlString = "https://www.omdbapi.com/?apikey=2c0d1dab&s=dark"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(response.search)
            } catch {
                print("Something went wrong \(error)")
                completion(nil)
            }
        }.resume()
    }
}
