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
    let user: User
    let token: String
    let message: String?
}

class WebService{
    
    //Auth Functions
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, AuthenticationError>)-> Void){
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
            completion(.success(loginResponse))
        }.resume()
    }
    
    func fetchUser(id: String, completion: @escaping (Result <User, AuthenticationError>) -> Void){
        guard let url = URL(string: "http://localhost:5000/api/user/\(id)") else{
            completion(.failure(.custom(errorMessage: "URL is invalid")))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data=data, error==nil else{
                completion(.failure(.custom(errorMessage: "No data recieved.")))
                return
            }
            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Error with user data.")))
                return
            }
            completion(.success(user))
        }.resume()
    }
    
    //Listing Functions
    func getProperties(token: String, completion: @escaping (Result<[Property], NetworkError>)-> Void){
        guard let url = URL(string: "http://localhost:5000/api/listing/") else{
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
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
            guard let properties = try? decoder.decode([Property].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(properties))
        }.resume()
    }
    
}
extension Formatter {
   static var customISO8601DateFormatter: ISO8601DateFormatter = {
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
      return formatter
   }()
}

extension JSONDecoder.DateDecodingStrategy {
   static var iso8601WithFractionalSeconds = custom { decoder in
      let dateStr = try decoder.singleValueContainer().decode(String.self)
      let customIsoFormatter = Formatter.customISO8601DateFormatter
      if let date = customIsoFormatter.date(from: dateStr) {
         return date
      }
      throw DecodingError.dataCorrupted(
               DecodingError.Context(codingPath: decoder.codingPath,
                                     debugDescription: "Invalid date"))
   }
}
