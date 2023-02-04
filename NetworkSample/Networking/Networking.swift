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
    
    /// convert the response into the object type
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
            // nicely format the JSON response before sending it to the debug console
            print(httpData.prettyPrintedJSON ?? "nil")
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

extension Data {
    var prettyPrintedJSON: String? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]) else { return nil }
        return String(decoding: data, as: UTF8.self)
    }
}
