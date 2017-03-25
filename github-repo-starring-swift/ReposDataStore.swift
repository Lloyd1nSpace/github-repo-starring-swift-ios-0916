//
//  FISReposDataStore.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    var repositories = [GithubRepository]()
    
    func getRepositoriesFromAPI(_ completion: @escaping () -> ()) {
        repositories = []
        
        GithubAPIClient.getRepositories { [weak self] (repos, error) in
            guard let strongSelf = self else { return }
            if let repos = repos {
                strongSelf.repositories.append(GithubRepository(dictionary: repos))
                completion()
            } else if let error = error {
                print("There was an error getting the repositories info: \(error.localizedDescription)")
            }
        }
    }
    
}
