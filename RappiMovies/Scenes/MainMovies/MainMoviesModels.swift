//
//  MainMoviesModels.swift
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

enum MainMovies{
    // MARK: Use cases
    
    enum Load{
        struct Request{
            let selectedCategory : Int
        }
        struct Response{
            let movies : [MovieModel]
        }
        struct ViewModel{
            let movies : [MovieModel]
        }
        
    }
    
    enum Detail {
        
        struct Request{
            let movie : MovieModel
        }
        struct Response{ }
        struct ViewModel{ }
    }
}