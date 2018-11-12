//
//  MoviesView.swift
//  RappiMovies
//
//  Created by Juan on 11/11/18.
//  Copyright © 2018 Juand. All rights reserved.
//

import Foundation
import UIKit

class MoviesView : UIView {
    
    let tableView : UITableView
    let pickerview: UIPickerView!
    let viewNoInternet: UIView!
    let lblNoInternet: UILabel!
    
    private let width:CGFloat = 160
    private let height:CGFloat = 100
    var topView : CGFloat = 0
    private var rotationAngle: CGFloat!

    var searchController = UISearchController(searchResultsController: nil)
    
    override init(frame: CGRect) {

        pickerview = UIPickerView()
        viewNoInternet = UIView()
        tableView = UITableView()
        lblNoInternet = UILabel()
        
        super.init(frame: frame)

        setupComponents()
        setupContraints()
        
        print(frame)

    }
    
    func setupBackground(){
        
        self.backgroundColor = UIColor.red
        var gl:CAGradientLayer!
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor.black.cgColor
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [ 0.2, 0.7]
        let backgroundLayer = gl
        backgroundLayer!.frame = CGRect(x: frame.minX , y: frame.minY, width: frame.width, height: frame.height)
        
        layer.insertSublayer(backgroundLayer!, at: 0)

    }
    
    
    func setupComponents(){
        
        isUserInteractionEnabled = false
        pickerview.translatesAutoresizingMaskIntoConstraints = true
        lblNoInternet.translatesAutoresizingMaskIntoConstraints = false
        lblNoInternet.numberOfLines = 0
        lblNoInternet.textAlignment = .center
        lblNoInternet.textColor = .white
        lblNoInternet.text = "No tienes conexión a internet, activa la conexión para ver los trailers"
        viewNoInternet.backgroundColor = UIColor(red: 210/255, green: 137/255, blue: 44/255, alpha: 1.0)
        viewNoInternet.translatesAutoresizingMaskIntoConstraints = false
        viewNoInternet.layer.cornerRadius = 10
        viewNoInternet.isHidden = true
        topView = statusBarHeight()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "tableMovies"
        tableView.showsVerticalScrollIndicator = false
        tableView.setValue (UIColor.clear, forKey: "tableHeaderBackgroundColor")
        tableView.backgroundColor = UIColor.clear
        
        addSubview(tableView)
        addSubview(pickerview)
        addSubview(viewNoInternet)
        viewNoInternet.addSubview(lblNoInternet)
        
        rotationAngle = -90 * (.pi/180)
        pickerview.transform = CGAffineTransform(rotationAngle: rotationAngle)
        pickerview.frame = CGRect(x: 0 - 150, y: topView, width: frame.width + 300, height: 50)
        pickerview.translatesAutoresizingMaskIntoConstraints = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContraints(){
       
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: topView + pickerview.frame.height + 5),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor ),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            viewNoInternet.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant : -13 ),
            viewNoInternet.leadingAnchor.constraint(equalTo: leadingAnchor, constant : 16 ),
            viewNoInternet.trailingAnchor.constraint(equalTo: trailingAnchor, constant : -16),
            viewNoInternet.heightAnchor.constraint(equalToConstant: 67)
            ])
        
        NSLayoutConstraint.activate([
            lblNoInternet.bottomAnchor.constraint(equalTo: viewNoInternet.bottomAnchor, constant : -8 ),
            lblNoInternet.leadingAnchor.constraint(equalTo: viewNoInternet.leadingAnchor, constant : 16 ),
            lblNoInternet.trailingAnchor.constraint(equalTo: viewNoInternet.trailingAnchor, constant : -16),
            lblNoInternet.topAnchor.constraint(equalTo: viewNoInternet.topAnchor, constant: 8)
            ])
        
        
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }

}
