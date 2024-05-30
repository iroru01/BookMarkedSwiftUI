//
//  LaunchScreen.swift
//  BooksRepeat
//
//  Created by Isabel Romero on 8/5/24.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack{
            if self.isActive: Bool = false{
                MainView()
            }
            else{
                Rectangle()
                    .background(Color.black)
                Image("BookMarked")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .background(.white)
    }
}

struct LaunchScreenPreview: PreviewProvider{
    static var previews: some View{
        LaunchScreen()
    }
}

#Preview {
    LaunchScreen()
}
