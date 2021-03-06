//
//  MovieDetailViewController.swift
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
import AVFoundation

protocol MovieDetailDisplayLogic: class {
    func displayVideo(viewModel: MovieDetail.Load.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic{
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?
    
    var movieDetailView : DetailView = DetailView()
    var videoID : String = ""
    // MARK: Object lifecycle
    var movie = MovieModel()
    fileprivate var lastOffset : CGFloat! = nil

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup(){
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidDisappear(_ animated: Bool) {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {

        if !Reachability.isConnectedToNetwork(){
            configureImageView()
        }else{
            movieDetailView.activityIndicator.startAnimating()
            loadInitialData()
        }
        
        movieDetailView.lblRate.text = String(movie.rate)
        UIView.animate(withDuration: 1, animations: {
            self.movieDetailView.lblRate.alpha = 1
        }, completion: nil)
    }
    
    override func loadView() {
        view = movieDetailView
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        movie = (router?.dataStore?.movie)!
        chargeDetailData()
        setupHandlers()
    }
    
   
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func loadInitialData(){
        let request = MovieDetail.Load.Request( movieID : (router?.dataStore?.movie.id)!)
        interactor?.doLoadInitialData(request: request)
    }
    
    func displayVideo(viewModel: MovieDetail.Load.ViewModel){

        videoID = viewModel.videoID
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if ( self.videoID != ""){
                self.configureWebView( videoID: self.videoID)
            }else{
                self.configureImageView()
                self.movieDetailView.lblIsTrailer.text = "Tráiler: No"
            }
        }
        //Trae "" si no hay video, de lo contrario trae el videoID
        
        
    }
    
    func configureWebView(videoID : String){
        movieDetailView.activityIndicator.startAnimating()
        movieDetailView.lblIsTrailer.text = "Tráiler: Si"
        
        movieDetailView.webView.isHidden = false
        
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        movieDetailView.webView.loadRequest( URLRequest(url: youtubeURL) )
        
    }
    
    
    func chargeDetailData(){
        
        movieDetailView.scrollView.delegate = self
        movieDetailView.webView.delegate = self
        movieDetailView.webView.isHidden = true
        movieDetailView.lblNameMovie.text = movie.name
        configureLabelDescription(description: movie.description)
        movieDetailView.lblDescription.text = movie.description
        movieDetailView.lblDate.text = movie.date.convertDateStringToDescription()
        
        //Configure background color to viewRate by rate
        if movie.rate < 5.0 {
            movieDetailView.viewBackgroundRate.backgroundColor = UIColor(red: 229/255, green: 103/255, blue: 68/255, alpha: 1.0)
        }else if movie.rate > 5.0 && movie.rate < 8.0 {
            movieDetailView.viewBackgroundRate.backgroundColor = UIColor(red: 255/255, green: 163/255, blue: 57/255, alpha: 1.0)
        }else {
            movieDetailView.viewBackgroundRate.backgroundColor = UIColor(red: 124/255, green: 190/255, blue: 11/255, alpha: 1.0)
        }
        
        //Configure sound in silence mode
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    func configureLabelDescription( description : String ){
        
        let heightLabel = movieDetailView.lblDescription.heightForView(text: description , font:
            movieDetailView.lblDescription.font, width: movieDetailView.screenSize.width - 36 )
        movieDetailView.constraintHeightDescription!.constant = heightLabel + 10
        
    }
    
    func setupHandlers(){
        movieDetailView.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    
    }
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }

    
    private func configureImageView(){
        
        movieDetailView.activityIndicator.stopAnimating()
        movieDetailView.imageLoader.isHidden = true
        movieDetailView.imageLoader.isHidden = false
        let urlImages = "https://image.tmdb.org/t/p/w400/"
        movieDetailView.imageLoader.cacheImage(urlString: urlImages + self.movie.image )
        movieDetailView.constraintImage!.constant = 10

        UIView.animate(withDuration: 0.4, animations: {

            self.movieDetailView.constraintImage!.constant = self.movieDetailView.imageLoader.frame.width * 1.5
            self.movieDetailView.layoutIfNeeded()

        })

    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


extension MovieDetailViewController : UIScrollViewDelegate{
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (lastOffset != nil){
            
            scrollView.contentOffset = CGPoint(x: 0, y: lastOffset)
            
        }else{
            
            let offset = scrollView.contentOffset.y
            let maximumScroll = self.view.frame.height / 4.5
            
            if ( offset <= -maximumScroll ){
                lastOffset = offset
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
    }

    
}


extension MovieDetailViewController : UIWebViewDelegate{
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        movieDetailView.activityIndicator.stopAnimating()
        movieDetailView.webView.isHidden = false
        
    }
}
