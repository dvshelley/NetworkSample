//
//  Networking.swift
//  NetworkSample
//
//  Created by Daniel Shelley on 12/10/22.
//

import Foundation

class Networking: NSObject {

    var session = URLSession.shared
    
    func request<T: Decodable>(_ urlRequest: URLRequest) async -> T? {
        do {
            let (data, response) = try await session.data(for: urlRequest, delegate: self)
            return try handle(response, with: data)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func request<T: Decodable>(url: String) async -> T? {
        guard let urlRequest = createRequest(url: url) else { return nil }
        return await request(urlRequest)
    }
    
    private func createRequest(url: String) -> URLRequest? {
        guard let requestUrl = URL(string: url) else { return nil }

        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
    
    private func handle<T: Decodable>(_ response: URLResponse?, with data: Data?) throws -> T? {
        if let response = response as? HTTPURLResponse, let httpStatus = response.httpStatus, !httpStatus.httpStatusType.isSuccess {
            print("http error: \(response.statusCode) \(httpStatus)")
            return nil
        }
        guard let httpData = data else { return nil }
        
        do {
            return try JSONDecoder().decode(T.self, from: httpData)
        } catch DecodingError.keyNotFound {
            print("keyNotFound")
            return nil
        } catch {
            print(error)
            let responseString = String(decoding: httpData, as: UTF8.self)
            print(responseString)
            return nil
        }
    }
}

extension Networking: URLSessionTaskDelegate { }
