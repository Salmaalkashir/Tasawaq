//
//  NetworkService.swift
//  Tasawaq
//
//  Created by Salma on 21/12/2023.
//

import Foundation

protocol NetworkServiceProtocol{
  func request<Data: Decodable>(path: Path, method: HTTPMethod, parameters: [String: Any]?, completion: @escaping (Result<Data,NetworkError>)-> Void)
}
class NetworkService: NetworkServiceProtocol{
  
  func createURL(path: Path)-> URL?{
    let baseUrl =
    "https://29f36923749f191f42aa83c96e5786c5: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@ios-q2-new-capital-admin-2022-2023.myshopify.com/admin/api/2023-01"
    let urlString = baseUrl + path.stringValue
    return URL(string: urlString)
  }
  
  func request<Data>(path: Path, method: HTTPMethod, parameters: [String : Any]?, completion: @escaping (Result<Data, NetworkError>) -> Void) where Data : Decodable {
    guard let url = createURL(path: path) else{
      completion(.failure(.invalidURL))
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    if let parameters = parameters{
      switch method{
      case .GET, .DELETE:
        // paramters to get and delete
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters.map{URLQueryItem(name: $0.key, value:"\($0.value)")}
        request.url = components?.url
        
      case .POST, .PUT:
        // http body for post and put
        do{
          request.httpBody = try JSONSerialization.data(withJSONObject: parameters ,options: .prettyPrinted)
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          request.addValue("application/json", forHTTPHeaderField: "Accept")
        }catch{
          completion(.failure(.requestFailed(error)))
          return
        }
      }
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      
      guard let data = data else{
        completion(.failure(.invalidResponse))
        return
      }
      
      do{
        let decodedObject = try JSONDecoder().decode(Data.self, from: data)
        print("T Type:\(Data.self)")
        completion(.success(decodedObject))
      }catch{
        completion(.failure(.decodingFailed(error)))
      }
      
      guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else{
        completion(.failure(.invalidResponse))
        return
      }
      
      if let error = error{
        completion(.failure(.requestFailed(error)))
        return
      }
    }
    task.resume()
  }
}
