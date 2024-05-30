//
//  EditBookView.swift
//  BooksRepeat
//
//  Created by Isabel Romero on 16/5/24.
//

import SwiftUI

struct EditBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var editedTitle: String
    @State private var editedAuthor: String
    @State private var editedGenre: String
    @State private var editedReview: String
    @State private var editedRating: Int
    
    let originalBook: Book
    @Binding var isEditing: Bool
    
    init(book: Book, isEditing: Binding<Bool>) {
        self.originalBook = book
        self._editedTitle = State(initialValue: book.title)
        self._editedAuthor = State(initialValue: book.author)
        self._editedGenre = State(initialValue: book.genre)
        self._editedReview = State(initialValue: book.review)
        self._editedRating = State(initialValue: book.rating)
        self._isEditing = isEditing
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $editedTitle)
                }
                
                Section(header: Text("Author")) {
                    TextField("Author", text: $editedAuthor)
                }
                
                Section(header: Text("Genre")) {
                    TextField("Genre", text: $editedGenre)
                }
                
                Section(header: Text("Review")) {
                    TextEditor(text: $editedReview)
                        .frame(height: 100)
                }
                
                Section(header: Text("Rating")) {
                    RatingView(rating: $editedRating)
                }
            }
            .navigationTitle("Edit Book")
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        dismiss()
                        isEditing = false
                    },
                trailing:
                    Button("Save") {
                        saveChanges()
                        dismiss()
                        isEditing = false
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    mutating func saveChanges() {
        // Guardar los cambios en el contexto del modelo
        do {
            try _modelContext.update {
                originalBook.title = editedTitle
                originalBook.author = editedAuthor
                originalBook.genre = editedGenre
                originalBook.review = editedReview
                originalBook.rating = editedRating
                originalBook.save()
            }
        } catch {
            print("Error saving changes: \(error.localizedDescription)")
        }
    }
}

struct EditBookView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleBook = Book(title: "Example Book", author: "John Doe", genre: "Fiction", review: "Great book!", rating: 4, currentDate: Date())
        let isEditing = Binding<Bool>.constant(true)
        
        return EditBookView(book: exampleBook, isEditing: isEditing)
            .environment(\.modelContext, PersistenceController.preview.container.viewContext)
    }
}
