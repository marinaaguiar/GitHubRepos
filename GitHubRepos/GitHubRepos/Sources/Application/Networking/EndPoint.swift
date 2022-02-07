
import Foundation

struct EndPoint {
//    let path: String
    let queryItems: [URLQueryItem]
    
    var url : URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search/repositories"
        components.queryItems = queryItems
        return components.url
    }
}

extension EndPoint {
    
    static func urlRequestWith(queryType: QueryType, query: String) -> EndPoint{
        var currentQuery: [URLQueryItem]
        
        switch queryType {
        case .page:
            currentQuery = [URLQueryItem(name: "q", value: "language:Swift"),
                            URLQueryItem(name: "sort", value: "stars"),
                            URLQueryItem(name: QueryType.page.rawValue, value: query)]
        case .fullName:
            currentQuery = [URLQueryItem(name: QueryType.fullName.rawValue, value:"org:\(QueryType.fullName.rawValue)"),
                            URLQueryItem(name: "pulls", value: "pulls")]
        }
        
        return EndPoint(queryItems: currentQuery)
    }
}

enum QueryType: String {
    case page
    case fullName
}
