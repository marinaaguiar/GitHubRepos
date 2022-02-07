//
//  RepoAPI.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 2/7/22.
//
//
//import Foundation
//
//struct RepoAPI {
//    
//    private let apiService = APIService()
//        
//    func buildURL(queryItems: [URLQueryItem]) -> URL? {
//        var componentBuilder = URLComponents()
//
//        componentBuilder.scheme = "https"
//        componentBuilder.host = "api.github.com"
//        componentBuilder.path = "/search/repositories"
//
//        componentBuilder.queryItems = [
//            URLQueryItem(name: "q", value: "language:Swift"),
//            URLQueryItem(name: "sort", value: "stars"),
//        ] + queryItems
//
//        return componentBuilder.url
//    }
//
//
//    func fetchRepos(page: Int, completion: @escaping (RepoResponse) -> Void) {
//        
//            guard let url = self.buildURL(queryItems: [
//                URLQueryItem(name: "page", value: "\(page)")
//            ]) else { return }
//        
////        print(url)
//        apiService.fetchGenericData(url: url, completion: completion)
//    }
//}
