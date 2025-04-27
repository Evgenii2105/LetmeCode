//
//  DataManagerService.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 19.04.2025.
//

import Foundation

protocol DataManagerService: AnyObject {
    func getFilms(filmsListResult: @escaping (Result<[Film], Error>) -> Void)
    func getFilmDetails(filmId: Int, filmDetailResult: @escaping (Result<FilmDetails, Error>) -> Void)
}

class DataManagerServiceImpl: DataManagerService {
    
    private let client = NetworkImpl()
    
    func getFilms(filmsListResult: @escaping (Result<[Film], Error>) -> Void) {
        client.request(endPoint: .films) { (result: Result<FilmListResponse, NetworkError>) in
            switch result {
            case .success(let filmListResponse):
                filmsListResult(.success(filmListResponse.films))
            case .failure(let error):
                filmsListResult(.failure(NetworkError.decodingFailed(error)))
            }
        }
    }
    
    func getFilmDetails(filmId: Int, filmDetailResult: @escaping (Result<FilmDetails, Error>) -> Void) {
        client.request(endPoint: .detailsFilm(id: filmId)) { [weak self] (result: Result<FilmDetails, NetworkError>) in
            switch result {
            case .success(let filmDetails):
                guard let self = self else { return }
                
                self.client.request(endPoint: .picturesFilm(id: filmId)) { (result: Result<FilmPicturesResponse, NetworkError>) in
                    switch result {
                    case .success(let pictures):
                        var filmDetails = filmDetails
                        filmDetails.pictures = pictures.items
                        filmDetailResult(.success(filmDetails))
                    case .failure(let error):
                        filmDetailResult(.failure(NetworkError.decodingFailed(error)))
                    }
                }
            case .failure(let error):
                filmDetailResult(.failure(NetworkError.decodingFailed(error)))
            }
        }
    }
}
