//
//  DataManagerService.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 19.04.2025.
//

import Foundation

protocol DataManagerService: AnyObject {
    func getFilms(filmsListResult: @escaping (Result<[Film], Error>) -> Void)
}

class DataManagerServiceImpl: DataManagerService {
    
    private let client = NetworkImpl()
    
    func getFilms(filmsListResult: @escaping (Result<[Film], Error>) -> Void) {
        client.request(endPoint: .films) { (result: Result<FilmListResponce, NetworkError>) in
            switch result {
            case .success(let filmListResponse):
                filmsListResult(.success(filmListResponse.films))
            case .failure(let error):
                filmsListResult(.failure(NetworkError.decodingFailed(error)))
            }
        }
    }
}
