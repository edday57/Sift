//
//  WebService.swift
//  Articulate
//
//  Created by Edward Day on 01/12/2022.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable{
    let email: String
    let password: String
}

struct LoginResponse: Codable{
    let success: Bool?
    let user: User?
    let token: String?
    let message: String?
}

class WebService{
    func login(email: String, password: String, completion: @escaping (Result<User, AuthenticationError>)-> Void){
        guard let url = URL(string: "http://localhost:5000/api/user/login") else{
            completion(.failure(.custom(errorMessage: "URL is invalid")))
            return
        }
        let body = LoginRequestBody(email: email, password: password)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data=data, error==nil else{
                completion(.failure(.custom(errorMessage: "No data received")))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            guard let token=loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            guard var user=loginResponse.user else {
                completion(.failure(.invalidCredentials))
                return
            }
            user.token = token
            //print(token)
            completion(.success(user))
        }.resume()
    }
    
    func getProperties(token: String, completion: @escaping (Result<[Property], NetworkError>)-> Void){
        guard let url = URL(string: "http://localhost:5000/api/listings/") else{
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data=data, error==nil else{
                completion(.failure(.noData))
                return
            }
            guard let properties = try? JSONDecoder().decode([Property].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(properties))
        }.resume()
    }
    
}
