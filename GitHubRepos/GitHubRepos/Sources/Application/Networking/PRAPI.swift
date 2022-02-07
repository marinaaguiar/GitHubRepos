//
//  PRAPI.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 2/7/22.
//

//import Foundation
//
//struct PRAPI {
//    
//    private let apiService = APIService()
//    
//    func buildURL(queryItems: [URLQueryItem]) -> URL? {
//        var componentBuilder = URLComponents()
//
//        componentBuilder.scheme = "https"
//        componentBuilder.host = "api.github.com"
//        componentBuilder.path = "/repos"
//
//        componentBuilder.queryItems = [
//            URLQueryItem(name: "pulls", value: "pulls"),
//        ] + queryItems
//
//        return componentBuilder.url
//    }
//    
//    func fetchPRs(fullName: String, completion: @escaping ([PullResquest]) -> Void) {
//        
//            guard let url = self.buildURL(queryItems: [
//                URLQueryItem(name: "username", value: "\(fullName)"),
//                URLQueryItem(name: "pulls", value: "pulls")
//            ]) else { return }
//        
//        print(url)
//        apiService.fetchGenericData(url: url, completion: completion)
//    }
//}
