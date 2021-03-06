//
//  MainMoviesViewController.swift
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

protocol MainMoviesDisplayLogic: class{
    func displayInitialData(viewModel: MainMovies.Load.ViewModel)
    func displayDetailView( viewModel: MainMovies.Detail.ViewModel )
}

class MainMoviesViewController: UIViewController, MainMoviesDisplayLogic{
  
    var interactor: MainMoviesBusinessLogic?
    var router: (NSObjectProtocol & MainMoviesRoutingLogic & MainMoviesDataPassing)?
    
    var lstMovies = [MovieModel]()
    var lstCustomMovies = [MovieModel]()
    
    let mainMoviesView : MoviesView = MoviesView()
    let cellMovieIdentifier = "MovieCell"
    let placeholderCellIdentifier = "PlaceholderCell"
    private let animals = ["Populares", "Más valoradas", "Estrenos"]
    var selectedCategory = 1
    private let width:CGFloat = 160
    private let height:CGFloat = 100
    private var isLoadingTable : Bool = true
    private var isFilter = false

    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
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
        let interactor = MainMoviesInteractor(worker: MainMoviesWorker())
        let presenter = MainMoviesPresenter()
        let router = MainMoviesRouter()
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
    
    override func loadView() {
        view = mainMoviesView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        startAnimation()
        loadInitialData()
        
        mainMoviesView.pickerview.frame = CGRect(x: 0 - 150, y: mainMoviesView.topView, width: mainMoviesView.frame.width + 300, height: 50)
        mainMoviesView.setupBackground()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupComponents()
        verifyInternet()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    // MARK: Do something
    func setupComponents(){
        
        let nib = UINib(nibName: cellMovieIdentifier, bundle: nil)
        let nib2 = UINib(nibName: placeholderCellIdentifier, bundle: nil)
        mainMoviesView.tableView.register(nib2, forCellReuseIdentifier: placeholderCellIdentifier)
        mainMoviesView.tableView.register(nib, forCellReuseIdentifier: cellMovieIdentifier)
        mainMoviesView.tableView.delegate = self
        mainMoviesView.tableView.dataSource = self
        mainMoviesView.pickerview.delegate = self
        mainMoviesView.pickerview.dataSource = self
        mainMoviesView.pickerview.selectRow(1, inComponent: 0, animated: true)
    }
   
    func displayDetailView(viewModel: MainMovies.Detail.ViewModel) {
        router?.routeToDetail()
    }
    
    // Show no internet view
    private func verifyInternet(){
        
        if !Reachability.isConnectedToNetwork(){
           
            mainMoviesView.viewNoInternet.isHidden = false
            let when = DispatchTime.now() + 2.5
            DispatchQueue.main.asyncAfter(deadline: when){
                UIView.animate(withDuration: 1) {
                    self.mainMoviesView.viewNoInternet.frame = CGRect(x: self.mainMoviesView.viewNoInternet.frame.minX, y: self.mainMoviesView.viewNoInternet.frame.minY + 200, width: self.mainMoviesView.viewNoInternet.frame.width, height: self.mainMoviesView.viewNoInternet.frame.height)
                }
            }
        }
        
    }
    
    private func changeLayout ( pickerHeight: CGFloat, tableHeight: CGFloat, tableY : CGFloat ){
        
        UIView.animate(withDuration: 0.5) {
            let pickerAlpha = pickerHeight * 100 / 5000
            self.mainMoviesView.pickerview.alpha = pickerAlpha < 0.9 ? (pickerAlpha * 0.9) : pickerAlpha
             self.mainMoviesView.pickerview.frame = CGRect(x: 0 - 150, y:  self.mainMoviesView.topView, width: self.view.frame.width + 300, height: pickerHeight)
             self.mainMoviesView.tableView.frame = CGRect(x:  self.mainMoviesView.tableView.frame.minX, y: tableY, width:  self.mainMoviesView.tableView.frame.width, height: tableHeight)
        }
        
    }
        
    func loadInitialData(){
        isLoadingTable = true
        let request = MainMovies.Load.Request(selectedCategory: selectedCategory)
        interactor?.doLoadInitialData(request: request)
        
    }
    
    func displayInitialData(viewModel: MainMovies.Load.ViewModel){
        
        lstMovies = viewModel.movies
        lstCustomMovies = viewModel.movies
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.isLoadingTable = false
            self.stopAnimation()
            self.mainMoviesView.isUserInteractionEnabled = true
            self.mainMoviesView.tableView.reloadData()
        }
        
    }
}


extension MainMoviesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.width - 44) * 1.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mainMoviesView.viewNoInternet.isHidden = true
        mainMoviesView.setupContraints()
        let movie = lstMovies[indexPath.row]
        let request = MainMovies.Detail.Request(movie: movie)
        interactor?.doLoadDetailView(reques: request)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isFilter{
            
            let offset = scrollView.contentOffset.y
            if offset >= 0 {
                
                if offset == 0{
                    changeLayout(pickerHeight: 50 , tableHeight: self.view.frame.height - (mainMoviesView.topView + mainMoviesView.pickerview.frame.height) , tableY: mainMoviesView.topView + mainMoviesView.pickerview.frame.height + 5)
                } else if(offset > 50){
                    
                    if offset < 150{
                        changeLayout(pickerHeight:0, tableHeight: self.view.frame.height - mainMoviesView.topView, tableY: mainMoviesView.topView)
                    }
                    
                }else{
                    changeLayout(pickerHeight: 50 - offset, tableHeight: self.view.frame.height - (mainMoviesView.topView + mainMoviesView.pickerview.frame.height - offset) , tableY: (mainMoviesView.topView + mainMoviesView.pickerview.frame.height - offset) < mainMoviesView.topView ? (mainMoviesView.topView) : (mainMoviesView.topView + mainMoviesView.pickerview.frame.height - offset) )
                }
                
            }else{
                
                changeLayout(pickerHeight: 50 , tableHeight: self.view.frame.height - (view.frame.height - mainMoviesView.topView - mainMoviesView.pickerview.frame.height - 5) , tableY: (mainMoviesView.topView + mainMoviesView.pickerview.frame.height + 5) )
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if !isFilter {
            mainMoviesView.searchController = UISearchController(searchResultsController: nil)
        }
        mainMoviesView.searchController.searchBar.endEditing(true)
        mainMoviesView.searchController.searchBar.placeholder = "Buscar"
        mainMoviesView.searchController.searchBar.barTintColor = UIColor.white
        mainMoviesView.searchController.searchBar.backgroundColor = UIColor.white
        mainMoviesView.searchController.dimsBackgroundDuringPresentation = false
        mainMoviesView.searchController.obscuresBackgroundDuringPresentation = false
        mainMoviesView.searchController.searchBar.delegate = self
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 120 ))
        view.backgroundColor = UIColor.clear
        view.addSubview( mainMoviesView.searchController.searchBar)
        
        return view
    }
    
}


extension MainMoviesViewController : UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isLoadingTable ? 3 : lstMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingTable{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: placeholderCellIdentifier, for: indexPath) as! PlaceholderCell
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellMovieIdentifier, for: indexPath) as! MovieCell
            let movie = lstMovies[indexPath.row]
            cell.setup(movie: movie)
            
            return cell
        }
       
    }
    
}

extension MainMoviesViewController :  UIPickerViewDataSource, UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainMoviesView.searchController.isActive = false
        selectedCategory = row
        startAnimation()
        loadInitialData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animals.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 150
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = animals[row]
        view.addSubview(label)
        
        // view rotation
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        return view
    }
    
}


extension MainMoviesViewController : UISearchBarDelegate, UISearchDisplayDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        mainMoviesView.tableView.isUserInteractionEnabled = true

        guard searchBar.text != "" else {
            lstMovies = lstCustomMovies
            mainMoviesView.tableView.reloadData()
            return
        }

        guard let text = searchBar.text else{
            return
        }

        lstMovies = lstCustomMovies.filter { (movie) -> Bool in
            movie.name.lowercased().contains(text.lowercased())
        }
        isFilter = true
        mainMoviesView.tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("texto cambiado")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        mainMoviesView.tableView.isUserInteractionEnabled = true
    }

//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//
//        return true
//    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        mainMoviesView.tableView.isUserInteractionEnabled = false
        changeLayout(pickerHeight:0, tableHeight: mainMoviesView.frame.height - mainMoviesView.topView, tableY: mainMoviesView.topView)
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()
        mainMoviesView.tableView.isUserInteractionEnabled = true
        isFilter = false
        lstMovies = lstCustomMovies
        mainMoviesView.tableView.reloadData()

    }
    
}
