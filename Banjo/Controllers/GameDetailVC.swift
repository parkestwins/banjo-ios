//
//  GameDetailVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 12/29/16.
//  Copyright © 2016 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - GameDetailVC: UIViewController, NibLoadable

class GameDetailVC: UIViewController, NibLoadable {
    
    // MARK: Properties
    
    var gameID: Int?
    var game: Game?
    let reuseIdentifier = AppConstants.IDs.genreCell
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
    @IBOutlet weak var coverLoadingIndicator: UIActivityIndicatorView!    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playersImage: UIImageView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        if let gameID = gameID {
            IGDBService.shared.load(IGDBRequest.getGameExpanded(gameID), type: [Game].self) { (parse) in
                guard !parse.isCancelled else { return }
                
                if let games = parse.result as? [Game] {
                    self.game = games[0]
                    self.updateUIForGame(games[0])
                    self.genreCollectionView.reloadData()
                } else {
                    print(parse.error ?? "error is nil!")
                }
            }
        }
    }
    
    @IBAction func backToSearch(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
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
    }
    
    private func updateUIForGame(_ game: Game) {
        // reset image
        coverLoadingIndicator.startAnimating()
        coverLoadingIndicator.isHidden = false
        
        developerLabel.text = game.developersString
        publisherLabel.text = game.publishersString
        summaryLabel.text = game.summary ?? "Summary does not exist."
        titleLabel.text = game.name
        releaseDateLabel.text = BanjoFormatter.shared.formatDateFromTimeIntervalSince1970(value: game.firstReleaseDate)
        
        ratingFieldLabel.text = "ESRB Rating"
        ratingLabel.text = game.esrb?.rating.name ?? "N/A"
        
        // FIXME: currently using last game mode to determine player image
        if let gameModes = game.gameModes {
            playersImage.image = gameModes[gameModes.count - 1].image
        } else {
            playersImage.image = #imageLiteral(resourceName: "single")
        }
        playersImage.tintColor = .banjoSlate
        
        // cover image
        if let cover = game.cover {
            let filePath = cover.url as NSString
            let fileExtension = filePath.pathExtension
            let urlString = "https://images.igdb.com/igdb/image/upload/t_cover_big_2x/\(cover.cloudinaryID).\(fileExtension)"
            coverImageView.imageFromCache(urlString)
        } else {
            setCoverImage(#imageLiteral(resourceName: "no-cover"))
        }
    }
    
    private func setCoverImage(_ image: UIImage) {
        coverLoadingIndicator.stopAnimating()
        coverLoadingIndicator.isHidden = true
        coverImageView.image = image
    }
}

// MARK: - GameDetailVC: UICollectionViewDelegate, UICollectionViewDataSource

extension GameDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let game = game {
            return game.genres?.count ?? 0
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

// MARK: - GameDetailVC: UICollectionViewDelegateFlowLayout

extension GameDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        configureCell(genreCell: sizingCell!, forIndexPath: indexPath)
        return sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}
