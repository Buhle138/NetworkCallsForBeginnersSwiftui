//
//  ContentView.swift
//  NetworkCallsForBeginnersSwiftui
//
//  Created by Buhle Radzilani on 2024/06/17.
//

import SwiftUI

struct ContentView: View {
    //adding the question mark because initially we don't have the user we only have it when we make the network call.
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack(spacing: 20 ) {
            Circle()
                .foregroundColor(.secondary)
                .frame(width: 120, height: 120)
            
            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "Bio PlaceHolder")
                .padding()
                .task {
                    do {
                        user = try await getUser()
                    }catch GHError.invalidUrl{
                        print("Invalid URL")
                    }catch GHError.invalidResponse{
                        print("Invalid Response")
                    }catch GHError.invalidData{
                        print("invalid data")
                    }catch{
                        print("Unexpected errors")
                    }
                   
                }
            
            Spacer()
        }
        .padding()
    }
    func getUser() async throws -> GitHubUser {
        
        //First thing we need is the URL where will get the data from.
        let endpoint = "https://api.github.com/users/Buhle138"
        
        //converting that String above into a URL. and handling the error in case where the we might have entered wrong url.
        guard let url = URL(string: endpoint) else {throw GHError.invalidUrl}
        
        let (data,  response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw GHError.invalidResponse
        }
        //Turning that JSON data into swift code. by decoding it.
        do{
            let decoder = JSONDecoder()
            //using converting from snake case  since the JSON had variables with underscores.
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        }catch{
            throw GHError.invalidData
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
    
}

enum GHError: Error{
    case invalidUrl
    case invalidResponse
    case invalidData
}
