//
//  NetWorkService.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 19.04.2025.
//

import Foundation

protocol DataManagerService: AnyObject {
    func getFilms()
}

class DataManagerServiceImpl: DataManagerService {
    
    private let client: NetWork = NetWorkImpl()
    
    func getFilms() {
        client.request(endPoint: .films, completion: <#T##(Result<Data, NetWorkError>) -> ()#>)
    }
}
