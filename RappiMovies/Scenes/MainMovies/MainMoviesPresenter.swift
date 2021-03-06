//
//  MainMoviesPresenter.swift
//  RappiMovies
//
//  Created by Juan on 11/11/18.
//  Copyright (c) 2018 Juand. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainMoviesPresentationLogic {
    func presentInitialData(response: MainMovies.Load.Response)
    func presentDetail( response: MainMovies.Detail.Response )
}

class MainMoviesPresenter: MainMoviesPresentationLogic {
    
    func presentDetail(response: MainMovies.Detail.Response) {
        
        let viewModel = MainMovies.Detail.ViewModel()
        viewController?.displayDetailView(viewModel: viewModel)
        
    }
    
    
    weak var viewController: MainMoviesDisplayLogic?
    
    // MARK: Do something
    
    func presentInitialData(response: MainMovies.Load.Response){
        let viewModel = MainMovies.Load.ViewModel(movies : response.movies)
        viewController?.displayInitialData(viewModel: viewModel)
    }
}
