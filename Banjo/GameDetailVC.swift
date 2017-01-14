//
//  GameDetailVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - GameDetailVC: UIViewController

class GameDetailVC: UIViewController {
    
    // MARK: Properties
    
    var game: Game?
    var selectedRelease: Release?
    let reuseIdentifier = AppConstants.IDs.genreCell
    var sizingCell: GenreCell?
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var playersLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingFieldLabel: UILabel!
    @IBOutlet weak var developerFieldLabel: UILabel!
    @IBOutlet weak var debugCoverLabel: UILabel!    
    @IBOutlet weak var coverLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var regionSelectButton: UIBarButtonItem!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playersImage: UIImageView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: RealmConstants.updateNotification), object: nil, queue: nil) { notification in
            self.setupUIForRelease()
        }
        setupUI()
    }
    
    // MARK: Deinitializer
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Actions
    
    @IBAction func swapRelease(_ sender: Any) {
        if let game = game, game.releases.count > 1 {
            performSegue(withIdentifier: AppConstants.Segues.showRelease, sender: game)
        }
    }
    
    @IBAction func backToSearch(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveSelectedRelease(segue: UIStoryboardSegue) {
        if let releasesTableVC = segue.source as? ReleaseSelectTableVC {
            if let newSelectedRelease = releasesTableVC.selectedRelease {
                selectedRelease = newSelectedRelease
                setupUIForRelease()
            }
        }
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        let genreCellNib = UINib(nibName: AppConstants.Nibs.genreCell, bundle: nil)
        let genreCellLayout = GenreCellLayout()
        genreCellLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        genreCollectionView.collectionViewLayout = genreCellLayout
        genreCollectionView.register(genreCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        sizingCell = (genreCellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! GenreCell?
        detailScrollView.contentInset.bottom = 30
        setupUIForRelease()
    }
    
    private func setupUIForRelease() {
        if let game = game, let release = selectedRelease {
            
            // reset image
            coverLoadingIndicator.startAnimating()
            coverLoadingIndicator.isHidden = false
            debugCoverLabel.isHidden = true
            coverImageView.image = nil
            
            publisherLabel.text = release.publisher
            summaryLabel.text = release.summary
            regionSelectButton.title = release.region?.abbreviation
            titleLabel.text = release.specialTitle ?? game.title
            releaseDateLabel.text = release.date != nil ? release.date!.toString() : AppConstants.Strings.unreleased
            
            // number of players
            if let playersLabelTuple = playersLabelText(game: game), playersLabelTuple.0 {
                playersImage.isHidden = false
                playersLabel.isHidden = false
                playersLabel.text = playersLabelTuple.1
            } else {
                playersImage.isHidden = true
                playersLabel.isHidden = true
            }
            
            // developer
            if let developer = release.developer {
                developerLabel.isHidden = false
                developerFieldLabel.isHidden = false
                developerLabel.text = developer
            } else {
                developerLabel.isHidden = true
                developerFieldLabel.isHidden = true
            }
            
            // game rating
            if let rating = release.rating, let ratingSystemAbbrevation = rating.system?.abbreviation {
                ratingLabel.isHidden = false
                ratingFieldLabel.isHidden = false
                ratingLabel.text = rating.name
                ratingFieldLabel.text = "\(ratingSystemAbbrevation) \(AppConstants.Strings.rating)"
            } else {
                ratingLabel.isHidden = true
                ratingFieldLabel.isHidden = true
            }
            
            // cover image
            if let coverImagePath = release.coverImagePath, coverImagePath.hasPrefix(FirebaseConstants.storagePrefix) {
                
                FirebaseClient.shared.getImage(path: coverImagePath) { image, error in
                    
                    // stop activity indicator
                    self.coverLoadingIndicator.stopAnimating()
                    self.coverLoadingIndicator.isHidden = true
                    
                    if let error = error {
                        self.debugCoverLabel.isHidden = false
                        print(error)
                    } else if let image = image {
                        self.coverImageView.image = image
                    }
                }
            }
        }
    }
    
    private func playersLabelText(game: Game) -> (Bool, String)? {
        let players = (game.playersMin.value, game.playersMax.value)
        switch(players) {
        case (nil, nil):
            return (false, "")
        case (let min, nil):
            return (true, "\(min!)")
        case (nil, let max):
            return (true, "\(max!)")
        case (let min, let max):
            return (true, "\(min!) - \(max!)")
        }
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let game = sender as? Game, let releaseSelectTableVC = segue.destination as? ReleaseSelectTableVC, segue.identifier == AppConstants.Segues.showRelease {
            releaseSelectTableVC.game = game
            releaseSelectTableVC.selectedRelease = selectedRelease
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        configureCell(genreCell: sizingCell!, forIndexPath: indexPath)
        return sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}
