//
//  GameDetailVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit
import Firebase

// MARK: - GameDetailVC: UIViewController

class GameDetailVC: UIViewController {
    
    // MARK: Properties
    
    var game: Game?
    let reuseIdentifier = "genreCell"
    var sizingCell: GenreCell?
    
    // MARK: Outlets
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var playersImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let genreCellNib = UINib(nibName: "GenreCell", bundle: nil)
        let genreCellLayout = GenreCellLayout()
        genreCellLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        genreCollectionView.collectionViewLayout = genreCellLayout        
        genreCollectionView.register(genreCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        sizingCell = (genreCellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! GenreCell?
        detailScrollView.contentInset.bottom = 30
        
        if let game = game {
            titleLabel.text = game.title
            // FIXME: pick release based on user region. fallback: pick first release by date?
            if let release = game.releases.first {                
                releaseDateLabel.text = DateHelper.dateToString(release.date)
                developerLabel.text = release.developer
                publisherLabel.text = release.publisher
                ratingLabel.text = release.rating?.abbreviation
                summaryLabel.text = release.summary
                let coverImagePath = release.coverImagePath
                if release.coverImagePath.hasPrefix("gs://") {
                    FIRStorage.storage().reference(forURL: coverImagePath).data(withMaxSize: INT64_MAX){ (data, error) in
                        if let error = error {
                            print("Error downloading: \(error)")
                            return
                        }
                        DispatchQueue.main.async {
                            self.coverImageView.image = UIImage(data: data!)
                        }
                    }
                }
            }
        }
    }
}

extension GameDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let game = game {
            return game.genres.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GenreCell
        configureCell(genreCell: cell, forIndexPath: indexPath)
        return cell
    }
    
    func configureCell(genreCell: GenreCell, forIndexPath indexPath: IndexPath) {
        if let game = game {
            let genre = game.genres[indexPath.row]
            genreCell.nameLabel.text = genre.name.uppercased()
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        configureCell(genreCell: self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}
