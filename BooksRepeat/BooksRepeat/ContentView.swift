//
//  ContentView.swift
//  Books
//
//  Created by Isabel Romero on 18/4/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment (\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    @State private var showingAddScreen = false
    
    @State private var criteria = ""
    
    @State private var currentTab = 0
    
    @State private var selectedGenre = "Fantasía"
    
    @State private var selectedFilter = "Puntuación"
    
    @State private var searchText = ""
    
//    @State private var isSearchBarVisible = false
    
    @State private var searchIsActive = false
    
    @Environment(\.dismissSearch) private var dismissSearch
    
    func filteredBooks() -> [Book]{
        if searchText.isEmpty{ //si el texto está vacío, mostrar todos los libros
            return books
        } else {
            let filtered = books.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.author.localizedCaseInsensitiveContains(searchText)}
                print("Filtered books count: \(filtered.count)")
                return filtered
            }
    }

    
    var body: some View {
        NavigationStack{
            Picker("Filtrar por:", selection: $selectedFilter) {
                Text("Puntuación").tag("Puntuación")
                Text("Género").tag("Género")
                Text("Estado").tag("Estado")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            List{
                if selectedFilter == "Puntuación" {
                    if !filteredBooks().filter({ $0.rating == 5 }).isEmpty {
                        Section("Mis favoritos") {
                            ForEach(filteredBooks().filter({ $0.rating == 5 })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.rating == 4 }).isEmpty {
                        Section("Me gustaron") {
                            ForEach(filteredBooks().filter({ $0.rating == 4 })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.rating == 3 }).isEmpty {
                        Section("Fue normalito") {
                            ForEach(filteredBooks().filter({ $0.rating == 3 })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.rating == 2 }).isEmpty {
                        Section("Meh") {
                            ForEach(filteredBooks().filter({ $0.rating == 2 })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.rating == 1 }).isEmpty {
                        Section("He perdido el tiempo") {
                            ForEach(filteredBooks().filter({ $0.rating == 1 })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                }
                
                else if selectedFilter == "Género" {
                    if !filteredBooks().filter({ $0.genre == "Fantasía" }).isEmpty {
                        Section("Fantasía") {
                            ForEach(filteredBooks().filter({ $0.genre == "Fantasía" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.genre == "Horror" }).isEmpty {
                        Section("Horror") {
                            ForEach(filteredBooks().filter({ $0.genre == "Horror" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({$0.genre == "Infantil" }).isEmpty {
                        Section("Infantil") {
                            ForEach(filteredBooks().filter({ $0.genre == "Infantil" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.genre == "Misterio" }).isEmpty {
                        Section("Misterio") {
                            ForEach(filteredBooks().filter({ $0.genre == "Misterio" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.genre == "Poemario" }).isEmpty {
                        Section("Poemario") {
                            ForEach(filteredBooks().filter({ $0.genre == "Poemario" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.genre == "Romance" }).isEmpty {
                        Section("Romance") {
                            ForEach(filteredBooks().filter({ $0.genre == "Romance" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                    if !filteredBooks().filter({ $0.genre == "Thriller" }).isEmpty {
                        Section("Thriller") {
                            ForEach(filteredBooks().filter({ $0.genre == "Thriller" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    
                }else if selectedFilter == "Estado" {
                    if !filteredBooks().filter({ $0.moment == "Leyendo" }).isEmpty {
                        Section("Leyendo") {
                            ForEach(filteredBooks().filter({ $0.moment == "Leyendo" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                    if !filteredBooks().filter({ $0.moment == "Leído" }).isEmpty {
                        Section("Leído") {
                            ForEach(filteredBooks().filter({ $0.moment == "Leído" }).sorted(by: { $0.rating > $1.rating })) { book in
                                NavigationLink(value: book){
                                    HStack{
                                        EmojiRatingView(rating: book.rating)
                                            .font(.largeTitle)
                                        VStack(alignment: .leading){
                                            Text(book.title)
                                                .font(.headline)
                                            Text(book.author)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: deleteBooks)
                        }
                    }
                }
            }
            .navigationDestination(for: Book.self){ book in
                DetailView(book: book)
            }
            
            Text("Total de libros: \(books.count)")
                .navigationTitle("BookMarked")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Add book", systemImage: "plus"){
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen){
                    AddBookView()
                }
                .scrollContentBackground(.hidden)
        }
        .searchable(text: $searchText, isPresented: $searchIsActive)
    }

        
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets{
            //find this book in our query
            let book = books[offset]
            
            //delete it from the context
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
