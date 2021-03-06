//
//  APIService.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import Foundation
import Alamofire

class APIService {
    
    func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else { return }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let error {
                print("ERROR IS HERE >>> \(error)")
            }
        }.resume()
    }
}

struct RepoAPI {
    
    private let apiService = APIService()
        
    private let basePath = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page="
    private var repoResponse: RepoResponse?

    func fetchRepos(page: Int, completion: @escaping (RepoResponse) -> Void) {
        apiService.fetchGenericData(urlString: basePath + String(page), completion: completion)
    }
}

struct PRAPI {
    
    private let apiService = APIService()

    private let basePath = "https://api.github.com/repos/"
    private let suffixPath = "/pulls"
        
    func fetchPRs(fullName: String, completion: @escaping ([PullResquest]) -> Void) {
        apiService.fetchGenericData(urlString: basePath + fullName + suffixPath, completion: completion)
    }
}
