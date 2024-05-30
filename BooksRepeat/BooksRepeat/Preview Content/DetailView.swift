//
//  DetailView.swift
//  Books
//
//  Created by Isabel Romero on 19/4/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    @State private var dragAmount = CGSize.zero
    
    let book: Book
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            Text(book.title)
                .font(.custom("Courier", size: 35))
//                .foregroundStyle(.secondary)
                .foregroundStyle(.blue)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                
            Text(book.author)
                .font(.title3)
                .foregroundStyle(.secondary)
                .padding(.bottom, 30)
            
            VStack(alignment: .leading){
                HStack{
                    Text("Tu opinión: ")
                        .foregroundStyle(.secondary)
                    
                    Text(book.review)
                }
                .padding(10)
                .padding(.horizontal, 30)
                    
                HStack {
                    Text("Estado del libro: ")
                        .foregroundStyle(.secondary)
                    Text(book.moment)
                }
                .padding(10)
                .padding(.horizontal, 30)
                
                HStack{
                    if let currentDateString = book.currentDateAsString() {
                        HStack{
                            Text("Día que lo has terminado:")
                                .foregroundStyle(.secondary)
                            Text(currentDateString)
                        }
                        
                    } else {
                        Text("")
                    }
                }
                .padding(10)
                .padding(.horizontal, 30)
                
            }
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 2)
                )
                .padding(30)
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){ }
        }message: {
            Text("Are you sure?")
        }
        .toolbar{
            Button("Delete this book", systemImage:"trash"){
                showingDeleteAlert = true
            }
        }
        
//        .toolbar{
//            Button(action: {
//                    isEditing.toggle()
//                }) {
//                    Image(systemName: isEditing ? "pencil.slash" : "pencil")
//                }
//                .foregroundColor(.primary)
//        }

    }
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test book", author: "Test author", genre: "Fantasy", review: "Great book", rating: 4, saveCurrentDate: true, moment: "Leído")
        return DetailView(book: example)
            .modelContainer(container)
    }catch{
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
