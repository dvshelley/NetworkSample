//
//  Networking.swift
//  NetworkSample
//
//  Created by Daniel Shelley on 12/10/22.
//

import Foundation

class Networking: NSObject {

    var session = URLSession.shared
    
    func request<T: Decodable>(_ urlRequest: URLRequest) async -> (T?, Error?) {
        do {
            let (data, response) = try await session.data(for: urlRequest, delegate: self)
            return try handle(response, with: data)
        }
        catch {
            print(error)
            return (nil, error)
        }
    }
    
    func request<T: Decodable>(url: String) async -> (T?, Error?) {
        guard let urlRequest = createRequest(url: url) else { return (nil, AppError.invalidUrlRequest) }
        return await request(urlRequest)
    }
    
    private func createRequest(url: String) -> URLRequest? {
        guard let requestUrl = URL(string: url) else { return nil }

        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    private func handle<T: Decodable>(_ response: URLResponse?, with data: Data?) throws -> (T?, Error?) {
        if let response = response as? HTTPURLResponse, let httpStatus = response.httpStatus, !httpStatus.httpStatusType.isSuccess {
            return (nil, httpStatus)
        }
        guard let httpData = data else { return (nil, AppError.badResponse) }
        
        do {
            let typeResponse = try JSONDecoder().decode(T.self, from: httpData)
            return (typeResponse, nil)
        } catch {
            print(error)
            let responseString = String(decoding: httpData, as: UTF8.self)
            print(responseString)
            return (nil, error)
        }
    }
}

extension Networking: URLSessionTaskDelegate { }

enum AppError: Error {
    case invalidUrlRequest
    case httpError(status: HTTPStatus)
    case badResponse
    case mappingFailed
}
