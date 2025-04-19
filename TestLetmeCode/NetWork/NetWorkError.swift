//
//  NetWorkError.swift
//  TestLetmeCode
//
//  Created by Евгений Фомичев on 19.04.2025.
//

import Foundation

enum NetWorkError: Error {
    case invalidURL
    case requestFailed(String)
    case noData
    case decodingFailed(Error)
}
