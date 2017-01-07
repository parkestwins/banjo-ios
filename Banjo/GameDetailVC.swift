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
    var selectedRelease: Release?
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
    
    // FIXME: better naming for "field" labels
    
    @IBOutlet weak var ratingFieldLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func swapRelease(_ sender: Any) {
        if let game = game {
            let randomIndex = Int(arc4random_uniform(UInt32(game.releases.count)))
            selectedRelease = game.releases[randomIndex]
            setupUIForRelease()
        }
    }
    
    // MARK: Setup UI
    
    func setupUI() {
        let genreCellNib = UINib(nibName: "GenreCell", bundle: nil)
        let genreCellLayout = GenreCellLayout()
        genreCellLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        genreCollectionView.collectionViewLayout = genreCellLayout
        genreCollectionView.register(genreCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        sizingCell = (genreCellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! GenreCell?
        detailScrollView.contentInset.bottom = 30
        setupUIForRelease()
    }
    
    func setupUIForRelease() {
        if let game = game, let release = selectedRelease {
            if let specialTitle = release.specialTitle {
                titleLabel.text = specialTitle
            } else {
                titleLabel.text = game.title
            }
            releaseDateLabel.text = release.date.toString()
            developerLabel.text = release.developer
            publisherLabel.text = release.publisher
            if let rating = release.rating {
                ratingLabel.isHidden = false
                ratingFieldLabel.isHidden = false
                if let ratingSystemAbbv = rating.system?.abbreviation {
                    ratingFieldLabel.text = "\(ratingSystemAbbv) Rating"
                }
                ratingLabel.text = rating.name
            } else {
                ratingLabel.isHidden = true
                ratingFieldLabel.isHidden = true
            }
            
            summaryLabel.text = release.summary
            if let coverImagePath = release.coverImagePath, coverImagePath.hasPrefix("gs://") {
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
            genreCell.backgroundColor = UIColor(hex: genre.colorHex)
            genreCell.nameLabel.text = genre.name.uppercased()
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        configureCell(genreCell: self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}