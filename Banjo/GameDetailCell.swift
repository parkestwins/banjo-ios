//
//  GameDetailCell.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - GameDetailCell: BaseCollectionCell

class GameDetailCell: BaseCollectionCell {
    
    // MARK: Properties
    
    var game: Game?
    var sizingCell: GenreCell?
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingFieldLabel: UILabel!
    @IBOutlet weak var developerFieldLabel: UILabel!
    @IBOutlet weak var playersImage: UIImageView!
    @IBOutlet weak var genreCollectionView: UICollectionView!    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    // MARK: NSObject
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                        
//        genreCollectionView.alwaysBounceHorizontal = true
//        genreCollectionView.dataSource = self
//        genreCollectionView.delegate = self
//        genreCollectionView.backgroundColor = UIColor.clear
        
//        let genreCellNib = UINib(nibName: AppConstants.Nibs.genreCell, bundle: nil)
//        let genreCellLayout = GenreCellLayout()
//        genreCellLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        genreCollectionView.collectionViewLayout = genreCellLayout
//        genreCollectionView.registerCellWithNib(GenreCell.self, bundle: Bundle.main)
//        sizingCell = (genreCellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! GenreCell?
    }
    
    func configureCell(genreCell: GenreCell, forIndexPath indexPath: IndexPath) {
        if let game = game, let genres = game.genres {
            let genre = genres[indexPath.row]
            switch(indexPath.row) {
            case 0:
                genreCell.backgroundColor = .banjoFern
            case 1:
                genreCell.backgroundColor = .banjoCornflowerBlue
            case 2:
                genreCell.backgroundColor = .banjoBlueberry
            case 3:
                genreCell.backgroundColor = .banjoGolden
            default:
                genreCell.backgroundColor = .banjoBrickOrange
            }
            genreCell.nameLabel.text = genre.name
        }
    }
}

//// MARK: - GameDetailCell: UICollectionViewDelegate
//
//extension GameDetailCell: UICollectionViewDelegate {}
//
//// MARK: - GameDetailCell: UICollectionViewDelegateFlowLayout
//
//extension GameDetailCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        configureCell(genreCell: sizingCell!, forIndexPath: indexPath)
//        return sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//    }
//}
//
//// MARK: - GameDetailCell: UICollectionViewDataSource
//
//extension GameDetailCell: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let game = game else { return 0 }
//        return game.genres?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: GenreCell = genreCollectionView.dequeueReusableCellFromNib(forIndexPath: indexPath)
//        configureCell(genreCell: cell, forIndexPath: indexPath)
//        return cell
//    }
//}
