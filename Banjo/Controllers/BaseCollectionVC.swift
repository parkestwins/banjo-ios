//
//  BaseCollectionVC.swift
//  Banjo
//
//  Created by Jarrod Parkes on 1/21/18.
//  Copyright © 2018 ParkesTwins. All rights reserved.
//

import UIKit

// MARK: - BaseCollectionVC: UICollectionViewController

public class BaseCollectionVC: UICollectionViewController {
    
    // MARK: Properties
    
    var dataSource = BaseCollectionDataSource() {
        didSet {
            setupCollectionView()
        }
    }
    
    var refreshControl = UIRefreshControl()
    
    // MARK: Life Cycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-arrow"), style: .plain, target: self, action: #selector(backTapped))
        
        collectionView?.delegate = self
        collectionView?.bounces = true
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        // register default cells
        collectionView?.registerCellWithNib(EmptyCollectionCell.self, bundle: Bundle.main)
        collectionView?.registerCellWithNib(ErrorCollectionCell.self, bundle: Bundle.main)
        collectionView?.registerSupplementaryViewWithNib(EmptySupplementaryCell.self, forKind: UICollectionElementKindSectionHeader, bundle: Bundle.main)
        collectionView?.registerSupplementaryViewWithNib(EmptySupplementaryCell.self, forKind: UICollectionElementKindSectionFooter, bundle: Bundle.main)
        
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        setupNavigation()
    }
    
    // MARK: Setup
    
    func setupCollectionView() {}
    
    func setupNavigation() {}
    
    // MARK: Actions
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        dataSource.reload(completion: { (obj) in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.collectionView?.collectionViewLayout.invalidateLayout()
                self.refreshControl.endRefreshing()
            }
        }) { (error) in
            print(error ?? "unknown error")
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.collectionView?.collectionViewLayout.invalidateLayout()
                self.refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: - BaseCollectionVC: UICollectionViewDelegateFlowLayout

extension BaseCollectionVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}

