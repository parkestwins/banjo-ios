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
    
    @IBOutlet weak var regionSelectButton: UIBarButtonItem!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var playersLabel: UILabel!
    
    @IBOutlet weak var playersImage: UIImageView!
    // FIXME: better naming for "field" labels
    
    @IBOutlet weak var ratingFieldLabel: UILabel!
    
    @IBOutlet weak var developerFieldLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Actions
    
    @IBAction func swapRelease(_ sender: Any) {
        if let game = game, game.releases.count > 1 {
            performSegue(withIdentifier: "showRelease", sender: game)
        }
    }
    
    @IBAction func backToSearch(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveSelectedRelease(segue: UIStoryboardSegue) {
        if let releasesTableVC = segue.source as? SelectReleaseTableVC {
            if let newSelectedRelease = releasesTableVC.selectedRelease {
                selectedRelease = newSelectedRelease
                setupUIForRelease()
            }
        }
    }
    
    // MARK: Setup UI
    
    func setupUI() {
        let genreCellNib = UINib(nibName: "GenreCell", bundle: nil)
        let genreCellLayout = GenreCellLayout()
        genreCellLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        genreCollectionView.collectionViewLayout = genreCellLayout
        genreCollectionView.register(genreCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        sizingCell = (genreCellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! GenreCell?
        detailScrollView.contentInset.bottom = 30
        setupUIForRelease()
    }
    
    func setupUIForRelease() {
        if let game = game, let release = selectedRelease {
            
            if let region = release.region {
                regionSelectButton.title = region.abbreviation
            }
            
            if let specialTitle = release.specialTitle {
                titleLabel.text = specialTitle
            } else {
                titleLabel.text = game.title
            }
            if let date = release.date {
                releaseDateLabel.text = date.toString()
            } else {
                releaseDateLabel.text = "Unreleased"
            }
            if let developer = release.developer {
                developerLabel.isHidden = false
                developerFieldLabel.isHidden = false
                developerLabel.text = developer
            } else {
                developerLabel.isHidden = true
                developerFieldLabel.isHidden = true
            }
            publisherLabel.text = release.publisher
            
            var playersText = ""
            if let playersMin = game.playersMin.value {
                playersText += "\(playersMin)"
            }
            if let playersMax = game.playersMax.value {
                if playersText == "" {
                    playersText += "\(playersMax)"
                } else {
                    playersText += "- \(playersMax)"
                }
            }
            if playersText == "" {
                playersImage.isHidden = true
                playersLabel.isHidden = true
            } else {
                playersImage.isHidden = false
                playersLabel.isHidden = false
                playersLabel.text = playersText
            }
            
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
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let game = sender as? Game, let selectReleaseTableVC = segue.destination as? SelectReleaseTableVC, segue.identifier == "showRelease" {
            selectReleaseTableVC.game = game
            selectReleaseTableVC.selectedRelease = selectedRelease
        }
    }
}

// MARK: - GameDetailVC: UICollectionViewDelegate, UICollectionViewDataSource

extension GameDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
            genreCell.nameLabel.text = genre.name.uppercased()
        }
    }
}

// MARK: - GameDetailVC: UICollectionViewDelegateFlowLayout

extension GameDetailVC: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        configureCell(genreCell: self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}
