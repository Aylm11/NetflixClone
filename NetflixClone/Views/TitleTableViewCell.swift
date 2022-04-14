//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by Ali YILMAZ on 8.04.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    
    private let playButton: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let upcomingPosterImage:UIImageView = {
       let poster = UIImageView()
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(upcomingPosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        
        applyConstraints()
    }
    
    
    private func applyConstraints(){
        
        let upcomingPosterImageConstraints = [
            upcomingPosterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            upcomingPosterImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            upcomingPosterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            upcomingPosterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: upcomingPosterImage.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        ]
        
        NSLayoutConstraint.activate(upcomingPosterImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    
    public func configure(model : TitleViewModel){
        
        guard let url = URL(string:"https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
      
        upcomingPosterImage.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
