//
//  QuizModel.swift
//  Quizzes
//
//  Created by Aaron Cabreja on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation


final class QuizModel {
    private static let filename = "FavoriteQuiz.plist"
    private static var quizzes = QuizModel.getQuiz()
    //making the initializer private
    
    static func getQuiz() -> [FavoriteQuiz]{
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename).path
        var quizFavorites = [FavoriteQuiz]()
        if FileManager.default.fileExists(atPath: path){
            if let data = FileManager.default.contents(atPath: path){
                do {
                    quizFavorites =  try PropertyListDecoder().decode([FavoriteQuiz].self, from: data)
                } catch {
                    print("property list deccoding error: \(error)")
                }
            } else {
                print("getPhotoJournal - data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
        return quizFavorites
    }
    static func addQuiz(quiz: FavoriteQuiz) {
        quizzes.append(quiz)
        save()
    }
    
    static func delete(atIndex index: Int) {
        quizzes.remove(at: index)
        save()
    }
    
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDiretory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(quizzes)
            
            try data.write(to: path, options: Data.WritingOptions.atomic)
            
        } catch {
            print("property list encoding error: \(error)")
        }
        print(DataPersistenceManager.filepathToDocumentsDiretory(filename: filename))
    }
    
    static func updateItem(updatedItem: FavoriteQuiz, atIndex index: Int) {
        quizzes[index] = updatedItem
        save()
    }
    static public func isFavorite(quizTitle: String) -> Bool {
        let index = getQuiz().index { $0.quizTitle == quizTitle }
        var found = false
        if let _ = index {
            found = true
        }
        return found
    }

}
