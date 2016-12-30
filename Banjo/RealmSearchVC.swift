//
//  RealmSearchVC.swift
//
//  Created by Adam Fish on 10/2/15.
//  Modified by Jarrod Parkes on 12/23/16.
//  Copyright © 2015 Adam Fish. All rights reserved.
//

import UIKit
import Realm
import Realm.Dynamic
import RealmSwift

// MARK: - Protocols

/// Method(s) to retrieve data from a data source
public protocol RealmSearchResultsDataSource {
    /**
     Called by the search view controller to retrieve the cell for display of a given object
     
     :param: searchViewController the search view controller instance
     :param: anObject             the object to be displayed by the cell
     :param: indexPath            the indexPath that the object resides at
     
     :return: instance of UITableViewCell that displays the object information
     */
    func searchViewController(controller: RealmSearchVC, cellForObject object: Object, atIndexPath indexPath: IndexPath) -> UITableViewCell
}

/**
 Method(s) to notify a delegate of ABFRealmSearchViewController events
 */
public protocol RealmSearchResultsDelegate {
    /**
     Called just before an object is selected from the search results table view
     
     :param: searchViewController the search view controller instance
     :param: anObject             the object to be selected
     :param: indexPath            the indexPath that the object resides at
     */
    func searchViewController(controller: RealmSearchVC, willSelectObject anObject: Object, atIndexPath indexPath: IndexPath)
    
    /**
     Called just when an object is selected from the search results table view
     
     :param: searchViewController the search view controller instance
     :param: selectedObject       the selected object
     :param: indexPath            the indexPath that the object resides at
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
    @IBInspectable public var entityName: String? {
        didSet {
            refreshSearchResults()
        }
    }
    
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
    
    /// Defines whether the search bar is inserted into the table view header
    ///
    /// Default is YES
    @IBInspectable public var searchBarInTableView: Bool = true
    
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
    
    /// The configuration for the Realm in which the entity resides
    ///
    /// Default is [RLMRealmConfiguration defaultConfiguration]
    public var realmConfiguration: Realm.Configuration {
        set {
            internalConfiguration = newValue
        }
        get {
            if let configuration = internalConfiguration {
                return configuration
            }
            
            return Realm.Configuration.defaultConfiguration            
        }
    }
    
    /// The Realm in which the given entity resides in
    public var realm: Realm {
        return try! Realm(configuration: realmConfiguration)
    }
    
    /// The underlying search results
    public var results: RLMResults<RLMObject>?
    
    /// The search bar for the controller
    public var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
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
        
        if searchBarInTableView {
            tableView.tableHeaderView = searchBar
            searchBar.sizeToFit()
        }
        else {
            searchController.hidesNavigationBarDuringPresentation = false
        }
                
        definesPresentationContext = true
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshSearchResults()
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
    // FIXME: viewLoaded was commented out. is it needed?
    // public var viewLoaded: Bool = false
    
    private var internalConfiguration: Realm.Configuration?
    
    private var token: RLMNotificationToken?
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        return controller
    }()
    
    private var rlmRealm: RLMRealm {
        let configuration = toRLMConfiguration(configuration: realmConfiguration)
        return try! RLMRealm(configuration: configuration)
    }
    
    private var isReadOnly: Bool {
        return realmConfiguration.readOnly
    }
    
    private func updateResults(predicate: NSPredicate?) {
        
        if let results = searchResults(entityName: entityName, inRealm: rlmRealm, predicate: predicate, sortPropertyKey: sortPropertyKey, sortAscending: sortAscending) {
            
            guard !isReadOnly else {
                self.results = results
                tableView.reloadData()
                return
            }
            
            token = results.addNotificationBlock({ [weak self] (results, change, error) in
                if let weakSelf = self {
                    if (error != nil || !weakSelf.isViewLoaded) {
                        return
                    }
                    
                    weakSelf.results = results
                    
                    let tableView = weakSelf.tableView
                    
                    // Initial run of the query will pass nil for the change information
                    if change == nil {
                        tableView?.reloadData()
                        return
                    }
                        
                        // Query results have changed, so apply them to the UITableView
                    else if let aChange = change {
                        tableView?.beginUpdates()
                        tableView?.deleteRows(at: aChange.deletions(inSection: 0), with: .automatic)
                        tableView?.insertRows(at: aChange.insertions(inSection: 0), with: .automatic)
                        tableView?.reloadRows(at: aChange.modifications(inSection: 0), with: .automatic)
                        tableView?.endUpdates()
                    }
                }
            })
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
    
    private func searchResults(entityName: String?, inRealm realm: RLMRealm?, predicate: NSPredicate?, sortPropertyKey: String?, sortAscending: Bool) -> RLMResults<RLMObject>? {
        
        if entityName != nil && realm != nil {
            
            var results = (predicate != nil) ? realm?.objects(entityName!, with: predicate!) : realm?.allObjects(entityName!)
            
            if (sortPropertyKey != nil) {
                
                let sort = RLMSortDescriptor(property: sortPropertyKey!, ascending: sortAscending)
                
                results = results?.sortedResults(using: [sort])
            }
            
            return results
        }
        
        return nil
    }
    
    private func toRLMConfiguration(configuration: Realm.Configuration) -> RLMRealmConfiguration {
        let rlmConfiguration = RLMRealmConfiguration()
        
        if configuration.fileURL != nil {
            rlmConfiguration.fileURL = configuration.fileURL
        }
        
        if configuration.inMemoryIdentifier != nil {
            rlmConfiguration.inMemoryIdentifier = configuration.inMemoryIdentifier
        }
        
        if configuration.syncConfiguration != nil {
            rlmConfiguration.syncConfiguration = RLMSyncConfiguration(user: (configuration.syncConfiguration?.user)!, realmURL: (configuration.syncConfiguration?.realmURL)!)
        }
        
        rlmConfiguration.encryptionKey = configuration.encryptionKey
        rlmConfiguration.readOnly = configuration.readOnly
        rlmConfiguration.schemaVersion = configuration.schemaVersion
        return rlmConfiguration
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
        if let results = results {
            let baseObject = results.object(at: UInt(indexPath.row)) as RLMObjectBase
            let object = baseObject as! Object
            
            resultsDelegate.searchViewController(controller: self, willSelectObject: object, atIndexPath: indexPath)
            
            return indexPath
        }
        
        return nil
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        if let results = results {
            let baseObject = results.object(at: UInt(indexPath.row)) as RLMObjectBase
            let object = baseObject as! Object
            
            resultsDelegate.searchViewController(controller: self, didSelectObject: object, atIndexPath: indexPath)
        }
    }
}

// MARK: - RealmSearchVC (UITableViewControllerDataSource)

extension RealmSearchVC {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = results {
            return Int(results.count)
        }
        
        return 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let results = results {
            let baseObject = results.object(at: UInt(indexPath.row)) as RLMObjectBase
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
