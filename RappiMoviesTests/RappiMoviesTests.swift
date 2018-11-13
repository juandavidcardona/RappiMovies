//
//  RappiMoviesTests.swift
//  RappiMoviesTests
//
//  Created by Juan on 11/11/18.
//  Copyright © 2018 Juand. All rights reserved.
//

import XCTest
@testable import RappiMovies

class RappiMoviesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Probar si interactor llama al worker en la llamada inicial
    func testFetchMoviesCallsWorkerToFetch (){
        
        //Given
        let movieWorkerSpy = MainMoviesWorkerSpy()
        let interator = MainMoviesInteractor(worker: movieWorkerSpy)
        interator.presenter = MainMoviesPresentationLogicSpy()
        
        //When
        let request = MainMovies.Load.Request(selectedCategory: 1)
        interator.doLoadInitialData(request: request)
        
        //Then
        XCTAssert(movieWorkerSpy.workerIsCalled, "La función doLoadInitialData en interactor no llama al worker para traer las peliculas ")
        
    }
    
    
    // Probar si interactor llama al presenter después de recibir las películas que le envía el worker
    func testFetchMoviesCallsPresenterToFetch (){
        
       
        //Given
        let expectation = self.expectation(description: #function)
        
        let movieWorkerSpy = MainMoviesWorkerSpy()
        let presenter = MainMoviesPresentationLogicSpy()
        let interator = MainMoviesInteractor(worker: movieWorkerSpy)
        interator.presenter = presenter
        
        let request = MainMovies.Load.Request(selectedCategory: 1)
        interator.doLoadInitialData(request: request)
        
        //When
        movieWorkerSpy.fetchMovies(selectedCat: 0) { (movies, error) in
            let response = MainMovies.Load.Response(movies: movies)
            presenter.presentInitialData(response: response)
            expectation.fulfill()
        }
        
        //Then
        waitForExpectations(timeout: 3)
        XCTAssert(presenter.presentIsCalled, "La función doLoadInitialData en interactor no llama al worker para traer las peliculas ")
    }
}
