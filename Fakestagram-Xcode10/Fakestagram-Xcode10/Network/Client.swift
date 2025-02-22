//
//  File.swift
//  Fakestagram-Xcode10
//
//  Created by Ruben Alejandro Leon Del Villar on 11/10/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation

class Client {
    static let fakestagram = Client(session: URLSession.shared, baseUrl: "https://fakestagram-api.herokuapp.com")
    let session: URLSession
    let baseUrl: String

    init(session: URLSession, baseUrl: String) {
        self.session = session
        self.baseUrl = baseUrl
    }

    typealias successfulResponse = (Data?) -> Void

    func get(path: String, success: @escaping successfulResponse) {
        request(method: "get", path: path, body: nil, success: success)
    }

    func post(path: String, body: Data?, success: @escaping successfulResponse) {
        request(method: "post", path: path, body: body, success: success)
    }

    func put(path: String, body: Data?, success: @escaping successfulResponse) {
        request(method: "put", path: path, body: body, success: success)
    }

    func delete(path: String, success: @escaping successfulResponse) {
        request(method: "delete", path: path, body: nil, success: success)
    }

    private func request(method: String, path: String, body: Data?, success: @escaping successfulResponse) {
        guard let req = buildRequest(method: method, path: path, body: body) else {
            debugPrint("Invalid request")
            return
        }

        session.dataTask(with: req) { (data, response, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            let response = HttpResponse(response: response)
            if response.isSuccessful() {
                success(data)
            }
            }.resume()
    }

    private func buildRequest(method: String, path: String, body: Data?) -> URLRequest? {
        var builder = RequestBuilder(baseUrl: self.baseUrl)
        builder.method = method
        builder.path = path
        builder.body = body
        if let token = Credentials.apiToken.get() {
            builder.headers = ["Authorization": "Bearer \(token)"]
        }
        return builder.request()
    }
}
