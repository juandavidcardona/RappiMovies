//
//  MovieModel.swift
//  RappiMovie
//
//  Created by Juan on 11/11/18.
//  Copyright © 2018 Juan. All rights reserved.
//

import Foundation

class MovieModel {
    
    var id : Int = 0
    var name : String = ""
    var date : String = ""
    var rate : Double = 0.0
    var description : String = ""
    var image : String = ""
    var vote_count : Int = 0
    
    init( id : Int, name : String, date : String, rate : Double, description : String, image: String, vote_count : Int ) {
        self.id = id
        self.name = name
        self.date = date
        self.rate = rate
        self.description = description
        self.image = image
        self.vote_count = vote_count
    }
    
    init() {

    }
    
}
