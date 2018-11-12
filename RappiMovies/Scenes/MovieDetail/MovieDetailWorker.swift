//
//  MovieDetailWorker.swift
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

class MovieDetailWorker{
    
    func fetchMovieID( movieID : Int , completitionHandler : @escaping ( ( String , Error?) -> Void ) ){
        
        Services.shared.fetchVideo(movieID: movieID) { (videoID, error) in
            completitionHandler(videoID, error)
        }
        
    }
}