//
//  RealmSearchVC.swift
//
//  Created by Adam Fish on 10/2/15.
//  Copyright © 2015 Adam Fish. All rights reserved.
//  github.com/bigfish24/ABFRealmSearchViewController
//
//  Modified by Jarrod Parkes on 12/23/16.
//

import UIKit
import Realm
import RealmSwift
import Realm.Dynamic

// MARK: - Protocols

/// Method(s) to retrieve data from a data source
public protocol RealmSearchResultsDataSource {
    /**
     Called by the search view controller to retrieve the cell for display of a given object
     
     - Parameters:
        - controller: the search view controller instance
        - object: the object to be displayed by the cell
        - indexPath: the indexPath that the object resides at
     
     - Returns: instance of UITableViewCell that displays the object information
     */
    func searchViewController(controller: RealmSearchVC, cellForObject object: Object, atIndexPath indexPath: IndexPath) -> UITableViewCell
}

/**
 Method(s) to notify a delegate of ABFRealmSearchViewController events
 */
public protocol RealmSearchResultsDelegate {
    /**
     Called just before an object is selected from the search results table view
     
     - Parameters:
        - controller: the search view controller instance
        - anObject: the object to be selected
        - indexPath: the indexPath that the object resides at
     */
    func searchViewController(controller: RealmSearchVC, willSelectObject anObject: Object, atIndexPath indexPath: IndexPath)
    
    /**
     Called just when an object is selected from the search results table view
     
     - Parameters:
        - controller: the search view controller instance
        - anObject: the selected object
        - indexPath: the indexPath that the object resides at
     */
    func searchViewController(controller: RealmSearchVC, didSelectObject anObject: Object, atIndexPath indexPath: IndexPath)
}

// MARK: - RealmSearchVC

/// The ABFRealmSearchViewController class creates a controller object that inherits UITableViewController and manages the table view within it to support and display text searching against a Realm object.
public class RealmSearchVC: UITableViewController, RealmSearchResultsDataSource, RealmSearchResultsDelegate {
    
    // MARK: Properties
    
    /// The data source object for the search view controller
    public var resultsDataSource: RealmSearchResultsDataSource!
    
    /// The delegate for the search view controller
    public var resultsDelegate: RealmSearchResultsDelegate!
    
    /// The entity (Realm object) name
    let entityType = Game.self
    
    /// The keyPath on the entity that will be searched against.
    @IBInspectable public var searchPropertyKeyPath: String? {
        didSet {
            if searchPropertyKeyPath?.contains(".") == false && sortPropertyKey == nil {
                sortPropertyKey = searchPropertyKeyPath
            }
            refreshSearchResults()
        }
    }
    
    /// The base predicate, used when the search bar text is blank. Can be nil.
    public var basePredicate: NSPredicate? {
        didSet {
            refreshSearchResults()
        }
    }
    
    /// The key to sort the results on.
    ///
    /// By default this uses searchPropertyKeyPath if it is just a key.
    /// Realm currently doesn't support sorting by key path.
    @IBInspectable public var sortPropertyKey: String? {
        didSet {
            refreshSearchResults()
        }
    }
    
    /// Defines whether the search results are sorted ascending
    ///
    /// Default is YES
    @IBInspectable public var sortAscending: Bool = true {
        didSet {
            refreshSearchResults()
        }
    }

    /// Defines whether the text search is case insensitive
    ///
    /// Default is YES
    @IBInspectable public var caseInsensitiveSearch: Bool = true {
        didSet {
            refreshSearchResults()
        }
    }
    
    /// Defines whether the text input uses a CONTAINS filter or just BEGINSWITH.
    ///
    /// Default is NO
    @IBInspectable public var useContainsSearch: Bool = false {
        didSet {
            refreshSearchResults()
        }
    }

    /// The underlying search results
    public var searchResults: Results<Object>?
    
    /// The search bar for the controller
    public var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    /// Search string at the moment of selection
    public var searchStringAtSelection = ""
    
    // MARK: Public Methods
    
    /// Performs the search again with the current text input and base predicate
    public func refreshSearchResults() {
        let searchString = searchController.searchBar.text
        let predicate = searchPredicate(text: searchString)        
        updateResults(predicate: predicate)
    }
    
    // MARK: Initialization
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        resultsDataSource = self
        resultsDelegate = self
    }
    
    override public init(style: UITableViewStyle) {
        super.init(style: style)
        resultsDataSource = self
        resultsDelegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        resultsDataSource = self
        resultsDelegate = self
    }
    
    // MARK: UIViewController
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        automaticallyAdjustsScrollViewInsets = false
        searchBar.sizeToFit()
        definesPresentationContext = true
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if searchStringAtSelection != "" {
            searchController.searchBar.text = searchStringAtSelection
            searchController.isActive = true
        }
        
        refreshSearchResults()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    // MARK: RealmSearchResultsDataSource
    
    public func searchViewController(controller: RealmSearchVC, cellForObject object: Object, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        print("You need to implement searchViewController(controller:,cellForObject object:,atIndexPath indexPath:)")
        return UITableViewCell()
    }
    
    // MARK: RealmSearchResultsDelegate
    
    public func searchViewController(controller: RealmSearchVC, didSelectObject anObject: Object, atIndexPath indexPath: IndexPath) {
        // Subclasses to redeclare
    }
    
    public func searchViewController(controller: RealmSearchVC, willSelectObject anObject: Object, atIndexPath indexPath: IndexPath) {
        // Subclasses to redeclare
    }
    
    // MARK: Private
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.dimsBackgroundDuringPresentation = false
        return controller
    }()

    private var searchResultsToken: RLMNotificationToken?
    
    private func updateResults(predicate: NSPredicate?) {
        
        if let results = searchResults(entityType: entityType, inRealm: RealmClient.shared.realm, predicate: predicate, sortPropertyKey: sortPropertyKey, sortAscending: sortAscending) {
            
            if (!isViewLoaded) {
                return
            } else {
                self.searchResults = results
                tableView?.reloadData()
            }
        }
    }
    
    private func searchPredicate(text: String?) -> NSPredicate? {
        if (text != "" &&  text != nil) {
            
            let leftExpression = NSExpression(forKeyPath: searchPropertyKeyPath!)
            
            let rightExpression = NSExpression(forConstantValue: text)
            
            let operatorType = useContainsSearch ? NSComparisonPredicate.Operator.contains : NSComparisonPredicate.Operator.beginsWith
            
            let options = caseInsensitiveSearch ? NSComparisonPredicate.Options.caseInsensitive : NSComparisonPredicate.Options(rawValue: 0)
            
            let filterPredicate = NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: NSComparisonPredicate.Modifier.direct, type: operatorType, options: options)
            
            if basePredicate != nil {
                
                let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [basePredicate!, filterPredicate])
                
                return compoundPredicate
            }
            
            return filterPredicate
        }
        
        return basePredicate
    }
    
    private func searchResults(entityType: Object.Type?, inRealm realm: Realm?, predicate: NSPredicate?, sortPropertyKey: String?, sortAscending: Bool) -> Results<Object>? {
        
        if entityType != nil && realm != nil {
            
            var results = (predicate != nil) ? realm?.objects(entityType!).filter(predicate!) : realm?.objects(entityType!)
            
            if let sortPropertyKey = sortPropertyKey {

                results = results?.sorted(byKeyPath: sortPropertyKey, ascending: sortAscending)
            }
            
            return results
        }
        
        return nil
    }
    
    private func runOnMainThread(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        }
        else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}

// MARK: - RealmSearchVC (UITableViewDelegate)

extension RealmSearchVC {
    
    public override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let results = searchResults {            
            let baseObject = results[indexPath.row] as RLMObjectBase
            let object = baseObject as! Object
            
            resultsDelegate.searchViewController(controller: self, willSelectObject: object, atIndexPath: indexPath)
            
            return indexPath
        }
        
        return nil
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        if let searchText = searchBar.text, searchText != "" {
            searchStringAtSelection = searchText
        } else {
            searchStringAtSelection = ""
        }
        
        if let results = searchResults {
            let baseObject = results[indexPath.row] as RLMObjectBase
            let object = baseObject as! Object
            
            resultsDelegate.searchViewController(controller: self, didSelectObject: object, atIndexPath: indexPath)
        }
    }
}

// MARK: - RealmSearchVC (UITableViewControllerDataSource)

extension RealmSearchVC {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = searchResults {
            return Int(results.count)
        }
        
        return 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let results = searchResults {
            let baseObject = results[indexPath.row] as RLMObjectBase
            let object = baseObject as! Object            
            let cell = resultsDataSource.searchViewController(controller: self, cellForObject: object, atIndexPath: indexPath)
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - RealmSearchVC: UISearchResultsUpdating

extension RealmSearchVC: UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) {
        refreshSearchResults()
    }
}

// MARK: - RealmSearchVC: UISearchBarDelegate

extension RealmSearchVC: UISearchBarDelegate {
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.contentInset = .zero
    }
}


