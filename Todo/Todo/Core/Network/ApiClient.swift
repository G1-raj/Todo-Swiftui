//
//  ApiClient.swift
//  Todo
//
//  Created by Govine Rajput on 02/10/26.
//

import Foundation

final class ApiClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return try await perform(request)
    }
    
    func post<T: Decodable, Body: Encodable>(_ type: T.Type, to url: URL, body: Body) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        return try await perform(request)
    }
    
    func put<T: Decodable, Body: Encodable>(_ type: T.Type, to url: URL, body: Body) async throws -> T {
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        return try await perform(request)
    }
    
    func delete(from url: URL) async throws {
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw ApiError.serverError(httpResponse.statusCode)
        }
        
    }
    
    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        
        do {
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                throw ApiError.serverError(
                    httpResponse.statusCode
                )
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            return try decoder.decode(T.self, from: data)

            
        } catch let error as ApiError {
            throw error
        } catch DecodingError.dataCorrupted {
            throw ApiError.decodingError
        } catch {
            throw ApiError.networkError(error)
        }
    }
    
    
}
