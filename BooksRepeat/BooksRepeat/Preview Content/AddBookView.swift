//
//  AddBookView.swift
//  Books
//
//  Created by Isabel Romero on 18/4/24.
//

import SwiftUI


struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasía"
    @State private var review = ""
//    @State private var currentDate = Date()
    @State private var moment = "Leído"
    
//    let bookWithDate = Book(title: "Title", author: "Author", genre: "Genre", review: "Review", rating: 5, saveCurrentDate: true, moment: "Moment") // Guarda la fecha actual
//    let bookWithoutDate = Book(title: "Title", author: "Author", genre: "Genre", review: "Review", rating: 5, saveCurrentDate: false, moment: "Moment") // No guarda la fecha
//    let today = Date()
    
    @State var isPresented: Bool = false
    
    var disableForm: Bool{
        title.count < 1 || author.count < 1 || review.count < 1
    }
    
    let genres = ["Fantasía", "Horror", "Infantil", "Misterio", "Poemario", "Romance", "Thriller"]
    
    let moments = ["Leído", "Leyendo"]
    
    var body: some View {
            NavigationStack{
                Form{
                    Section{
                        TextField("Título del libro", text: $title)
                        TextField("Nombre del autor", text: $author)
                        
                        Picker("Género",selection: $genre){
                            ForEach(genres, id: \.self){
                                Text($0)
                            }
                        }
                        
                        Picker("Estado",selection: $moment){
                            ForEach(moments, id: \.self){
                                Text($0)
                            }
                        }
                        
                        VStack {
                            if moment == "Leído" {
                                DatePicker("¿Cuándo lo terminaste?", selection: .constant(Date()), in: ...Date(), displayedComponents: .date)
                            } else {
                                Text("Lo estás leyendo")
                            }
                        }
                        
                    }
                    
                    
                    Section("Tu opinión"){
                        TextField("Escribe una reseña", text: $review)
                        RatingView(rating: $rating)
                    }
                        
                    Section{
                        Button("Guardar") {
                            let newBook: Book
                            if moment == "Leído" {
                                newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, saveCurrentDate: true, moment: moment)
                            } else {
                                newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, saveCurrentDate: false, moment: moment)
                            }
                            modelContext.insert(newBook)
                            isPresented = true
                            dismiss()
                        }
                    }
                    .disabled(disableForm)
                }
                .navigationTitle("Añadir libro")
            }
    }
}


#Preview {
    AddBookView()
}
