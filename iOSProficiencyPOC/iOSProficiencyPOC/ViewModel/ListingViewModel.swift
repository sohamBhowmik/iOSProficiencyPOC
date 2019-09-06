//
//  ListingViewModel.swift
//  iOSProficiencyPOC
//
//  Created by Soham Bhowmik on 05/09/19.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

class ListingViewModel
{
    var listener: ((ListingModel?)->())?
    
    var listingModel: ListingModel? {
        didSet
        {
            listener?(listingModel)
        }
    }
    
    func fetchListingData()
    {
        NetworkingManager.sharedManager.fetchListingData {[weak self] (data, response, error) in
            
            guard let strongSelf = self else {return}
            
            if let httpResponse = response as? HTTPURLResponse
            {
                if httpResponse.statusCode == 200, error == nil, data != nil
                {
                    //success
                    do {
                        let str = String.init(data: data!, encoding: .ascii)
                        let newData = str?.data(using: .utf8)
                        strongSelf.listingModel = try JSONDecoder().decode(ListingModel.self, from: newData!)
                    }
                    catch let parsingError {
                        print(parsingError)
                    }
                }
                else {
                    //handle failure case
                }
            }
        }
    }
}

extension ListingViewModel
{
    func numberOfListing() -> Int
    {
        return listingModel?.info?.count ?? 0
    }
    
    func titleOfListing(atIndex index: Int) -> String?
    {
        var title: String?
        
        if let info = listingInfo(atIndex: index)
        {
            title = info.title
        }
        
        return title
    }
    
    func descriptionOfListing(atIndex index: Int) -> String?
    {
        var desc: String?
        
        if let info = listingInfo(atIndex: index)
        {
            desc = info.description
        }
        
        return desc
    }
    
    func imageURLOfListing(atIndex index: Int) -> String?
    {
        var imageURLString: String?
        
        if let info = listingInfo(atIndex: index)
        {
            imageURLString = info.imageURLString
        }
        
        return imageURLString
    }
}

extension ListingViewModel
{
    fileprivate func listingInfo(atIndex index: Int) -> ListingInfo?
    {
        var info: ListingInfo?
        
        if listingModel?.info?.count ?? 0 > index
        {
            info = listingModel!.info![index]
        }
        
        return info
    }
}
