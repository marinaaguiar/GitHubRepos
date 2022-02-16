//
//  APIService.swift
//  GitHubRepos
//
//  Created by Marina Aguiar on 1/24/22.
//

import Foundation

class APIService {
    
    func fetchGenericData<T: Decodable>(endPoint: EndPoint, completion: @escaping (Result<T, NSError>) -> ()) {
        
        debugPrint(endPoint.url)
        
        guard let url = endPoint.url else {
            return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Invalid URL"])))
        }

        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            if let error = error {
                completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": error.localizedDescription])))
                return
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Can't get data"])))
            }
            
            do {
                let genericData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(genericData))
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.debugPrint("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.debugPrint("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.debugPrint("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.debugPrint("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}


