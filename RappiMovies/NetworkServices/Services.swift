//
//  Services.swift
//  RappiMovie
//
//  Created by Juan on 11/11/18.
//  Copyright © 2018 Juan. All rights reserved.
//

import Foundation

class Services: NSObject {
    static let shared = Services()
    
    let apiKey = "2ec82b20379954a22595ad9e4a08893f"
    let lenguaje = "es-CO"
    
    func fetchMovies( selectedCategory: Int ,completion: @escaping ( [MovieModel]?, Error?) -> ()) {
        
        var lstMovies : [MovieModel] = []
        
        let page = 1
      
        var typeMovies = "popular"
        if(selectedCategory == 1){
            typeMovies = "top_rated"
        }else if(selectedCategory == 2){
            typeMovies = "upcoming"
        }
        
        let endpoint = "https://api.themoviedb.org/3/movie/\(typeMovies)?api_key=\(apiKey)&language=\(lenguaje)&page=\(page)"
        let endpointUrl = URL(string: endpoint)
        
        var request = URLRequest(url: endpointUrl!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
//            if error != nil{
//                completion(nil,error)
//            }
            
            if data != nil{
                
                guard let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else { return }
                
                guard let items = responseDictionary["results"] as? [[String:Any]] else {return}
                
                for item in items {
                    
                    let id = item["id"] as! Int
                    let name : String = item["title"] as! String
                    let date : String = item["release_date"] as! String
                    let rate : Double = item["vote_average"] as! Double
                    let description : String = item["overview"] as! String
                    let image : String = item["poster_path"] as! String
                    let vote_count : Int = item["vote_count"] as! Int
                    
                    let movie = MovieModel(id: id, name: name, date: date, rate: rate, description: description, image: image, vote_count: vote_count )
                    
                    lstMovies.append(movie)
                }
                
                completion(lstMovies, nil)
               
            }else{
                completion(nil,error)
            }
            
        }
        task.resume()
        
    }
    
    func fetchVideo( movieID: Int ,completion: @escaping ( String, Error?) -> ()) {
      
        let endpoint = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)&language=\(lenguaje)"
        
        let endpointUrl = URL(string: endpoint)
        
        var request = URLRequest(url: endpointUrl!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil{
                completion("",error)
            }
            
            if data != nil{
                
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                    
                    guard let items = responseDictionary["results"] as? [[String:Any]] else {return}
                        
                    if items.count > 0{
                        let movieID = items[0]["key"] as! String
                        completion(movieID,nil)
                    }else{
                        completion("", error )
                    }
                }
            }else{
                completion("", error )
            }
        }
        task.resume()
        
        
        
    }
}
