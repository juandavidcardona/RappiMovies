//
//  MovieDetailModels.swift
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

enum MovieDetail{
    // MARK: Use cases
    
    enum Load{
        struct Request{
            let movieID : Int
        }
        struct Response{
            let videoID : String
        }
        struct ViewModel{
            let videoID : String
        }
    }
}
