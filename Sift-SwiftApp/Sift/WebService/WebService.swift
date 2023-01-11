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

struct LoginRequestBody: Codable{
    let email: String
    let password: String
}

struct User: Codable{
    let email: String?
    let signedUp: Bool?
    let name: String?
    let about: String?
    let image: String?
    let dob: String?
    var token: String?
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
    
}
