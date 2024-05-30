//  Book.swift
//  Books
//
//  Created by Isabel Romero on 18/4/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var currentDate: Date?
    var moment: String
    
    init(title: String, author: String, genre: String, review: String, rating: Int, saveCurrentDate: Bool = false, moment: String) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.moment = moment
        
        if saveCurrentDate {
            self.currentDate = Date()
        } else {
            self.currentDate = nil
        }
    }
    
    func currentDateAsString() -> String? {
        guard let date = currentDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        return dateFormatter.string(from: date)
    }
}
