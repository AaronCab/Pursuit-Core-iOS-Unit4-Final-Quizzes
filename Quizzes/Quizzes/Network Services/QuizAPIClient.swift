//
//  QuizAPIClient.swift
//  Quizzes
//
//  Created by Aaron Cabreja on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation
final class QuizAPIClient {
static func getQuiz(completionHandler: @escaping (AppError?, [Quiz]?) -> Void) {
    let urlString = "http://5c4d4c0d0de08100147c59b5.mockapi.io/api/v1/quizzes"
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET") { (error, data) in
        if let error = error {
            completionHandler(error, nil)
        } else if let data = data {
            do {
                let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
                completionHandler(nil, quizzes)
            } catch {
                completionHandler(AppError.jsonDecodingError(error), nil)
            }
        }
    }
}
}
