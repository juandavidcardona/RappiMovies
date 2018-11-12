//
//  MovieCell.swift
//  RappiMovie
//
//  Created by Juan on 11/11/18.
//  Copyright © 2018 Juan. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var shadowBottom: UIImageView!
    
    let rateLabel : UILabel = UILabel()

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    private let shapeLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()


    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code

        mainImage.layer.masksToBounds = false
        mainImage.layer.cornerRadius = 20
        mainImage.clipsToBounds = true
        shadowBottom.layer.masksToBounds = false
        shadowBottom.layer.cornerRadius = 10
        shadowBottom.clipsToBounds = true

        center = CGPoint(x: mainImage.frame.minX + 30 , y: mainImage.frame.minY + 30)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 15, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.red.cgColor
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.lineWidth = 4
        trackLayer.strokeEnd = 3
        self.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 163/255, blue: 57/255, alpha: 1.0).cgColor
        shapeLayer.lineCap = .round
        shapeLayer.lineWidth = 4
        
        rateLabel.frame = CGRect(x: mainImage.frame.minX + 21 , y: mainImage.frame.minY + 22 , width: 18, height: 12)
        rateLabel.text = "0.0"
        rateLabel.textColor = UIColor.black
        rateLabel.adjustsFontSizeToFitWidth = true
        rateLabel.textAlignment = .center
        
        self.layer.addSublayer(shapeLayer)
        self.addSubview(rateLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
        
        // Configure the view for the selected state
    }
    
    private func updateRate(rate : Double){
        
        let value = rate * 0.8 / 10
        
        if rate < 5.0 {
            
            shapeLayer.strokeColor = UIColor(red: 229/255, green: 103/255, blue: 68/255, alpha: 1.0).cgColor
            
        }else if rate > 5.0 && rate < 8.0 {
            
            shapeLayer.strokeColor = UIColor(red: 255/255, green: 163/255, blue: 57/255, alpha: 1.0).cgColor

        }else {
           shapeLayer.strokeColor = UIColor(red: 124/255, green: 190/255, blue: 11/255, alpha: 1.0).cgColor
        }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = value
        animation.duration = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "circulAnimation")
        
    }
    
    func setup ( movie : MovieModel ){
        
        let urlImages = "https://image.tmdb.org/t/p/w400/"
        
        self.accessibilityIdentifier = String(movie.id)
        self.isAccessibilityElement = true
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.titleMovie.text = movie.name
        self.rateLabel.text = String(movie.rate)
        
        self.updateRate(rate: movie.rate)
        
        self.date.text = movie.date.convertDateStringToDescription()
        self.mainImage.cacheImage(urlString: urlImages + movie.image )
        
        
    }
    
}
