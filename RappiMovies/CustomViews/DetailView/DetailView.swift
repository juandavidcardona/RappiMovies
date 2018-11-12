//
//  DetailView.swift
//  RappiMovies
//
//  Created by Juan on 11/11/18.
//  Copyright © 2018 Juand. All rights reserved.
//

import Foundation
import UIKit

class DetailView : UIView {
    
    let backButton : UIButton
    let scrollView : UIScrollView
    let heartButton : UIButton
    let webView : UIWebView
    let imageLoader : UIImageView
    let lblNameMovie : UILabel
    let lblDate : UILabel
    let lblIsTrailer : UILabel
    let lblDescription : UILabel
    let viewBackgroundRate : UIView
    let lblRate : UILabel
    let viewWidth : UIView
    var constraintHeightDescription : NSLayoutConstraint? = nil
    let screenSize: CGRect = UIScreen.main.bounds
    let activityIndicator: UIActivityIndicatorView
    var constraintImage: NSLayoutConstraint? = nil
    
    override init(frame: CGRect) {
        backButton = UIButton()
        heartButton = UIButton()
        scrollView = UIScrollView()
        webView = UIWebView()
        imageLoader = UIImageView()
        lblNameMovie = UILabel()
        lblDate = UILabel()
        lblIsTrailer = UILabel()
        lblDescription = UILabel()
        viewBackgroundRate = UIView()
        lblRate = UILabel()
        viewWidth = UIView()
        activityIndicator = UIActivityIndicatorView()
        
        super.init(frame: frame)
        
        setupComponents()
        setupContraints()
    }
    
    func setupComponents(){
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        scrollView.showsVerticalScrollIndicator = false
        lblIsTrailer.text = "Tráiler: No"
        lblDescription.numberOfLines = 0
        lblDescription.textAlignment = .justified
        backButton.setImage(UIImage(named: "back"), for: UIControl.State.normal)
        heartButton.setImage(UIImage(named: "heart2"), for: UIControl.State.normal)
        lblRate.textColor = .white
        lblRate.textAlignment = .center
        activityIndicator.color = UIColor(red: 255/255, green: 166/255, blue: 51/255, alpha: 1.0)
        
        viewBackgroundRate.layer.cornerRadius = 20
        self.backgroundColor = UIColor.white
        viewWidth.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        imageLoader.translatesAutoresizingMaskIntoConstraints = false
        lblNameMovie.translatesAutoresizingMaskIntoConstraints = false
        lblDate.translatesAutoresizingMaskIntoConstraints = false
        lblIsTrailer.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblRate.translatesAutoresizingMaskIntoConstraints = false
        viewBackgroundRate.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        addSubview(scrollView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(heartButton)
        scrollView.addSubview(webView)
        scrollView.addSubview(imageLoader)
        scrollView.addSubview(lblNameMovie)
        scrollView.addSubview(lblDate)
        scrollView.addSubview(lblIsTrailer)
        scrollView.addSubview(lblDescription)
        scrollView.addSubview(viewBackgroundRate)
        scrollView.addSubview(viewWidth)
        scrollView.addSubview(lblRate)
        scrollView.addSubview(activityIndicator)

    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContraints(){
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            ])
        
        NSLayoutConstraint.activate([
            viewWidth.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewWidth.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewWidth.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewWidth.widthAnchor.constraint(equalToConstant: screenSize.width)
            ])
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: 37),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 11),
            backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 18),
            ])

        NSLayoutConstraint.activate([
            heartButton.heightAnchor.constraint(equalToConstant: 34),
            heartButton.widthAnchor.constraint(equalToConstant: 34),
            heartButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 11),
            heartButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
            ])

        constraintImage = imageLoader.heightAnchor.constraint(equalToConstant: 390)
        
        NSLayoutConstraint.activate([
            constraintImage!,
            imageLoader.topAnchor.constraint(equalTo: heartButton.bottomAnchor, constant: 8),
            imageLoader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageLoader.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

            ])

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: imageLoader.topAnchor, constant: 8),
            webView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: imageLoader.bottomAnchor),
            ])

        NSLayoutConstraint.activate([
            lblNameMovie.topAnchor.constraint(equalTo: imageLoader.bottomAnchor, constant: 8),
            lblNameMovie.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant : 20),
            lblNameMovie.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            lblNameMovie.heightAnchor.constraint(equalToConstant: 37)
            
            ])

        NSLayoutConstraint.activate([
            lblDate.topAnchor.constraint(equalTo: imageLoader.bottomAnchor, constant: 38),
            lblDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant : 20),
            lblDate.heightAnchor.constraint(equalToConstant: 21)
            
            ])

        NSLayoutConstraint.activate([
            lblIsTrailer.topAnchor.constraint(equalTo: lblDate.bottomAnchor),
            lblIsTrailer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant : 20),
            lblIsTrailer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40),
            lblIsTrailer.heightAnchor.constraint(equalToConstant: 21)
            ])
        
        constraintHeightDescription = lblDescription.heightAnchor.constraint(equalToConstant: 195)
        
        NSLayoutConstraint.activate([
            lblDescription.topAnchor.constraint(equalTo: lblIsTrailer.bottomAnchor,constant: 8),
            lblDescription.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant : 20),
            lblDescription.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            constraintHeightDescription!,
            lblDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            ])

        NSLayoutConstraint.activate([
            viewBackgroundRate.heightAnchor.constraint(equalToConstant: 40),
            viewBackgroundRate.widthAnchor.constraint(equalToConstant: 40),
            viewBackgroundRate.topAnchor.constraint(equalTo: imageLoader.bottomAnchor,constant: 20),
            viewBackgroundRate.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            ])

        NSLayoutConstraint.activate([
            lblRate.bottomAnchor.constraint(equalTo: viewBackgroundRate.bottomAnchor),
            lblRate.topAnchor.constraint(equalTo: viewBackgroundRate.topAnchor),
            lblRate.leadingAnchor.constraint(equalTo: viewBackgroundRate.leadingAnchor),
            lblRate.trailingAnchor.constraint(equalTo: viewBackgroundRate.trailingAnchor),

            ])
        
        NSLayoutConstraint.activate([
            
            activityIndicator.widthAnchor.constraint(equalToConstant: 35),
            activityIndicator.heightAnchor.constraint(equalToConstant: 35),
            activityIndicator.centerXAnchor.constraint(equalTo: imageLoader.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageLoader.centerYAnchor),

            ])
        
    }
    
}


