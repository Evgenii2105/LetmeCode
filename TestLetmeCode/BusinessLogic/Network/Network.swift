//
//  NetWork.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 19.04.2025.
//

import Foundation
import UIKit

//protocol Network: AnyObject {
//    func request(endPoint: NetworkImpl.EndPoint,
//                               completion: @escaping (Result<Data, NetworkError>) -> Void)
//}

class NetworkImpl {
    
    static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
    func request<T: Decodable>(endPoint: EndPoint,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = createRequest(endPoint: endPoint) else { return completion(.failure(.invalidURL)) }
        
        request(urlRequest: urlRequest, completion: completion)
    }
    
    private func request<T: Decodable>(urlRequest: URLRequest,
                                       completion: @escaping (Result<T, NetworkError>) -> ()) {
        let task = URLSession.shared.dataTask(with: urlRequest) {
            data, _, error  in
            guard let data = data else { return completion(.failure(.noData)) }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    private func createRequest(endPoint: EndPoint) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = BaseUrl.baseURL
        urlComponents.path = endPoint.path
        
        guard let url = urlComponents.url else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        urlRequest.setValue("de1db718-950e-449d-88a1-39a41062cee6", forHTTPHeaderField: "X-API-KEY")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    private enum BaseUrl {
        static let baseURL = "kinopoiskapiunofficial.tech"
    }
    
    enum APIMethod: String {
        case get = "Get"
        case post = "Post"
        case delete = "Delete"
    }
    
    enum EndPoint {
        case films
        case detailsFilm(id: Int)
        case movieFilm(id: Int)
        
        var scheme: String {
            return "https"
        }
        
        var path: String {
            switch self {
            case .films:
                return "/api/v2.2/films"
            case .detailsFilm(let id):
                return "/api/v2.2/films/\(id)"
            case .movieFilm(let id):
                return "/v2.2/films/\(id)/images"
            }
        }
        
        var method: APIMethod {
            switch self {
            case .films:
                return .get
            case .detailsFilm(let id):
                return .get
            case .movieFilm(let id):
                return .get
            }
        }
    }
}
