//
//  WebService.swift
//  Articulate
//
//  Created by Edward Day on 01/12/2022.
//

import Foundation
import UIKit
enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}

struct LoginRequestBody: Codable{
    let email: String
    let password: String
}

struct SignUpRequestBody: Codable{
    let email: String?
    let password: String?
    let name: String?
    let dob: Date?
    let about: String?
    let mobile: Int?
    let fromGoogle: Bool
}

struct LikeRequestBody: Codable{
    let user: String
    let listing: String
}
struct ListingRequestBody: Codable{
    let filters: Filters
}

struct LoginResponse: Codable{
    let success: Bool?
    let user: User
    let token: String
    let message: String?
}

struct GoogleLoginResponse: Codable{
    let success: Bool?
    let user: User
    let token: String
    let message: String?
    let newAccount: Bool
}

struct SignUpResponse: Codable{
    var status: Int?
    let user: User?
    let token: String?
    let message: String?
}

struct DiscoverResponse: Codable{
    let discoverProperties: [Property]
    let additionalProperties: [Property]
}

class WebService{
    let hostname = "159.65.51.173"
    //let hostname = "localhost"
    //Auth Functions
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, AuthenticationError>)-> Void){
        guard let url = URL(string: "http://\(hostname):5000/api/user/login") else{
            completion(.failure(.custom(errorMessage: "URL is invalid")))
            return
        }
        let body = LoginRequestBody(email: email, password: password)
        var request = URLRequest(url: url)
        print(email)
        print(password)
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
    
    func loginGoogle(idToken: String, completion: @escaping (Result<GoogleLoginResponse, AuthenticationError>)-> Void){
        guard let url = URL(string: "http://\(hostname):5000/api/user/googleLogin") else{
            completion(.failure(.custom(errorMessage: "URL is invalid")))
            return
        }
        guard let body = try? JSONEncoder().encode(["idToken": idToken]) else {
            completion(.failure(.custom(errorMessage: "Error encoding authentication data")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data=data, error==nil else{
                completion(.failure(.custom(errorMessage: "No data received")))
                return
            }
            guard let loginResponse = try? JSONDecoder().decode(GoogleLoginResponse.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Error decoding response")))
                return
            }
            completion(.success(loginResponse))
        }.resume()
        
    }
    
    func verifyEmail(email: String) async throws -> Bool{
        guard var url = URL(string: "http://\(hostname):5000/api/user/checkEmailExists") else{
            fatalError("Invalid URL")
        }
        let email = URLQueryItem(name: "email", value: email)
        url.append(queryItems: [email])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw RuntimeError("Error while fetching likes data")
        }
        let exists = try JSONDecoder().decode(Bool.self, from: data)
        return exists
    }
    
    func signUpUser(details: SignUpRequestBody) async throws -> SignUpResponse{
        guard let url = URL(string: "http://\(hostname):5000/api/user/signup") else{
            fatalError("Invalid URL")
        }
        let body = details
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard var signUpResponse = try? JSONDecoder().decode(SignUpResponse.self, from: data) else {
            throw RuntimeError("Error decoding sign up response")
        }
        signUpResponse.status = (response as? HTTPURLResponse)?.statusCode
        return signUpResponse
    }
    
    func signUpUserWithPic(details: SignUpRequestBody, image: UIImage) async throws -> SignUpResponse{
        guard let url = URL(string: "http://\(hostname):5000/api/user/signupImg") else{
            fatalError("Invalid URL")
        }
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = image.jpegData(compressionQuality: 0.5)
        
        var body = Data()
        
        if let imageData = imageData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        print(imageData)
        let jsonData = try? JSONEncoder().encode(details)
        
        if let jsonData = jsonData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"json\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            body.append(jsonData)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: request)
        guard var signUpResponse = try? JSONDecoder().decode(SignUpResponse.self, from: data) else {
            throw RuntimeError("Error decoding sign up response")
        }
        signUpResponse.status = (response as? HTTPURLResponse)?.statusCode
        return signUpResponse
    }
    
//    func loginGoogle(idToken: String) async throws -> LoginResponse{
//        guard let url = URL(string: "http://\(hostname):5000/api/user/googleLogin") else{
//            fatalError("Invalid URL")
//        }
//        guard let body = try? JSONEncoder().encode(["idToken": idToken]) else {
//            throw RuntimeError("Error while encoding Google login data")
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = body
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            throw RuntimeError("Error while logging in user")
//        }
//        guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
//            throw RuntimeError("Error while decoding login data")
//        }
//        return loginResponse
//    }
    
    
    func fetchUser(id: String, completion: @escaping (Result <User, AuthenticationError>) -> Void){
        guard let url = URL(string: "http://\(hostname):5000/api/user/\(id)") else{
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
    
    func addLike(user: String, listing: String, token: String, completion: @escaping (Int)-> Void){
        guard let url = URL(string: "http://\(hostname):5000/api/like/add") else{
            completion(404)
            return
        }
        let body = LikeRequestBody(user: user, listing: listing)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(body)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data=data, let response=response as? HTTPURLResponse, error==nil else{
                completion(404)
                return
            }
            if response.statusCode==200{
                completion(response.statusCode)
            }
            else {
                completion(response.statusCode)
            }
            
        }.resume()
        
    }
    
    func AaddLike(user: String, listing: String, token: String) async throws{
        guard let url = URL(string: "http://\(hostname):5000/api/like/add") else{
            fatalError("Invalid URL")
        }
        let body = LikeRequestBody(user: user, listing: listing)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(body)
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw RuntimeError("Error while fetching likes data")
        }
    }
    
    func AtoggleLike(user: String, listing: String, token: String) async throws -> Int{
        guard var url = URL(string: "http://\(hostname):5000/api/like/toggle") else{
            fatalError("Invalid URL")
        }
        let user = URLQueryItem(name: "user", value: user)
        let listing = URLQueryItem(name: "listing", value: listing)
        url.append(queryItems: [user, listing])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 201 else {
            throw RuntimeError("Error while fetching likes data")
        }
        return (response as? HTTPURLResponse)!.statusCode
    }
//    func getLikes(id: String, token: String, completion: @escaping (Result <[String], NetworkError>) -> Void){
//        guard let url = URL(string: "http://\(hostname):5000/api/like/\(id)") else{
//            completion(.failure(.invalidURL))
//            return
//        }
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data=data, error==nil else{
//                completion(.failure(.noData))
//                return
//            }
//            guard let likes = try? JSONDecoder().decode([String].self, from: data) else {
//                completion(.failure(.decodingError))
//                return
//            }
//            completion(.success(likes))
//        }.resume()
//    }
    
    func AgetLikes(id: String, token: String) async throws -> [String] {
        guard let url = URL(string: "http://\(hostname):5000/api/like/\(id)") else{
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw RuntimeError("Error while fetching likes data")
        }
        let likes = try JSONDecoder().decode([String].self, from: data)
        return likes
    }
    
    func aGetAgentProperties(id: String, skip: Int, token: String) async throws -> [Property]{
        guard let url = URL(string: "http://\(hostname):5000/api/listing/user/\(id)") else{
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw RuntimeError("Error while fetching agent listings")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        let listings = try decoder.decode([Property].self, from: data)
        return listings
    }
    
    //Listing Functions
    func getProperties(filters: Filters, skip: Int, token: String, completion: @escaping (Result<[Property], NetworkError>)-> Void){
        guard var url = URL(string: "http://\(hostname):5000/api/listing/") else{
            completion(.failure(.invalidURL))
            return
        }
        let skip = URLQueryItem(name: "skip", value: String(skip))
        url.append(queryItems: [skip])
        let body = ListingRequestBody(filters: filters)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(body)
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
    
    
    func getSavedProperties(id: String, filters: Filters, skip: Int, token: String, completion: @escaping (Result<[Property], NetworkError>)-> Void){
        guard var url = URL(string: "http://\(hostname):5000/api/like/posts/\(id)") else{
            completion(.failure(.invalidURL))
            return
        }
        let skip = URLQueryItem(name: "skip", value: String(skip))
        url.append(queryItems: [skip])
        let body = ListingRequestBody(filters: filters)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(body)
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
    
    func getDiscover(id: String, token: String, viewed: [String], views: [PropertyViewStruct], completion: @escaping (Result<DiscoverResponse, NetworkError>)-> Void){
        guard let url = URL(string: "http://\(hostname):5000/api/listing/discover/cb/\(id)") else{
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //encoder.dateEncodingStrategy = .secondsSince1970
        request.httpBody = try? JSONEncoder().encode(views)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data=data, error==nil else{
                completion(.failure(.noData))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
            guard let properties = try? decoder.decode(DiscoverResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(properties))
        }.resume()
    }
    func getDiscoverCF(id: String, token: String, viewed: [String], completion: @escaping (Result<[Property], NetworkError>)-> Void){
        guard let url = URL(string: "http://\(hostname):5000/api/listing/discover/cf/\(id)") else{
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(viewed)
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
