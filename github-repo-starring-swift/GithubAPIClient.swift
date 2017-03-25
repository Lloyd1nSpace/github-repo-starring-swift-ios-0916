//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

struct GithubAPIClient {
    
    static func getRepositories(with completion: @escaping ([String : Any]?, Error?) -> ()) {
        
        let urlString = "https://api.github.com/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
        guard let url = URL(string: urlString) else {
            print("There was an error unwrapping the url in the GithubAPIClient")
            return
        }
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("There was an error unwrapping the data in the GitHubAPIClient")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] {
                    for repoDict in json {
                        completion(repoDict, nil)
                    }
                }
            } catch {
                print("There was an issue deserializing the JSON: \(error.localizedDescription)")
                completion(nil, error)
            }
            if let error = error {
                print("There was an error with the URLSession request in the GithubAPIClient: \(error.localizedDescription)")
            }
            }.resume()
    }
    
}
