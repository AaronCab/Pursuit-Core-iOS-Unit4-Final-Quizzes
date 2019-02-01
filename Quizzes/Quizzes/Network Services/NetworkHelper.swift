//
//  NetworkHelper.swift
//  Quizzes
//
//  Created by Alex Paul on 1/31/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

final class NetworkHelper {
  private init() {}
  static let shared = NetworkHelper()
  func performDataTask(endpointURLString: String,
                       httpMethod: String,
                       handler: @escaping (AppError?, Data?) -> Void) {
    guard let url = URL(string: endpointURLString) else {
      handler(AppError.badURL(endpointURLString), nil)
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        handler(AppError.networkError(error), nil)
      }
      guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
          let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
          handler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        handler(nil, data)
      }
    }
    task.resume()
  }
}
