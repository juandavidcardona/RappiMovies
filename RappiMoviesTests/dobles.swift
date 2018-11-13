//
//  dobles.swift
//  RappiMoviesTests
//
//  Created by Juan on 11/12/18.
//  Copyright © 2018 Juand. All rights reserved.
//

import Foundation
@testable import RappiMovies

// MARK - Test doubles

class MainMoviesPresentationLogicSpy : MainMoviesPresentationLogic {
    
    var movies : [MovieModel] = []
    var presentIsCalled : Bool = false
    
    func presentInitialData(response: MainMovies.Load.Response) {
        movies = response.movies
        presentIsCalled = true
    }
    
    func presentDetail(response: MainMovies.Detail.Response) {
        //
    }
}

class MainMoviesWorkerSpy : MainMoviesWorker {
    
    var movies : [MovieModel] = []
    var workerIsCalled = false
    
    override func fetchMovies(selectedCat : Int,completitionHandler : @escaping ( ([MovieModel], Error?) -> Void ) ){
        
        self.workerIsCalled = true
        
        Services.shared.fetchMovies(selectedCategory: selectedCat) { (movies, error) in
            completitionHandler(((movies) ?? nil)!, error)
        }
        
    }
    
}
