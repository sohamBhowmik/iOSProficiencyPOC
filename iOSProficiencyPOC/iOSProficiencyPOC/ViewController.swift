//
//  ViewController.swift
//  iOSProficiencyPOC
//
//  Created by Soham Bhowmik on 05/09/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let listingViewModel = ListingViewModel()
        
    weak fileprivate var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    static let listingCellReuseId = "listingCellReuseId"
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white
        
        setupUIElements()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupListingViewModelListeners()
        setupTableView()
        view.showLoader()
        listingViewModel.fetchListingData()
    }

    fileprivate func setupListingViewModelListeners()
    {
        listingViewModel.listener = {[weak self] listingModel in
            guard let strongSelf = self else { return }
            
            strongSelf.view.removeLoader()
            if let pageTitle = listingModel?.title
            {
                strongSelf.title = pageTitle
            }
            
            strongSelf.refreshControl.endRefreshing()
            strongSelf.tableView.reloadData()
        }
    }
    
    @objc func refresh(sender:AnyObject) {
        view.showLoader()
        listingViewModel.fetchListingData()
        ImageDownloader.shared.refreshCache()
    }
}

extension ViewController
{
    fileprivate func setupUIElements()
    {
        let tempTableView = UITableView()
        tableView = tempTableView
        view.addSubview(tableView)
        
        tableView.addConstraintsToOverlap(superView: view)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    fileprivate func setupTableView()
    {
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: ViewController.listingCellReuseId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70.0
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingViewModel.numberOfListing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.listingCellReuseId, for: indexPath) as! ListingTableViewCell
        
        var image: UIImage?
        
        if let imageURL = listingViewModel.imageURLOfListing(atIndex: indexPath.row)
        {
            image = ImageDownloader.shared.image(fromUrlString: imageURL)
        }
        
        cell.configureCell(withTitle: listingViewModel.titleOfListing(atIndex: indexPath.row), description: listingViewModel.descriptionOfListing(atIndex: indexPath.row), image: image)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let imageURL = listingViewModel.imageURLOfListing(atIndex: indexPath.row)
        {
            if ImageDownloader.shared.image(fromUrlString: imageURL) == nil {
                downloadImage(forIndexPath: indexPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        ImageDownloader.shared.cancelImageOperation(forUniqueId: generateUniqueId(forIndexPath: indexPath))
    }
}

extension ViewController
{
    fileprivate func downloadImage(forIndexPath indexPath: IndexPath)
    {
        //Very basic image downloader and cache implemented to demonstrate lazy loading. We may ideally use third party codes like AlamofireImage to download and cache images
        if let imageURL = listingViewModel.imageURLOfListing(atIndex: indexPath.row)
        {
            ImageDownloader.shared.downloadImage(fromURL: imageURL, uniqueId: generateUniqueId(forIndexPath: indexPath)) {[weak self] (image, uniqueId, error) in
               
                guard let strongSelf = self else {return}
                
                if image != nil {
                    strongSelf.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
        }
    }
    
    
    //Ideally we may use MD5Hash of the url to generate unique id. For simple demonstration purpose simple string is used.
    fileprivate func generateUniqueId(forIndexPath indexPath: IndexPath) -> String
    {
        return "\(indexPath.row),\(indexPath.section)"
    }
}

