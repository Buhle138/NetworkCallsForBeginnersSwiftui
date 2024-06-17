//
//  ContentView.swift
//  NetworkCallsForBeginnersSwiftui
//
//  Created by Buhle Radzilani on 2024/06/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20 ) {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120, height: 120)
            
            Text("Username")
                .bold()
                .font(.title3)
            
            Text("This is where the github bio will go. let's make it long so it spans two lines")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
