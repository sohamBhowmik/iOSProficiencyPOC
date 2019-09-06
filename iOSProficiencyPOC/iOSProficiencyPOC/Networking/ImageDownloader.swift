//
//  ImageDownloader.swift
//  iOSProficiencyPOC
//
//  Created by Soham Bhowmik on 05/09/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ImageDownloader
{
    //Very basic image downloader and cache implemented to demonstrate lazy loading. We may use third party codes like AlamofireImage to download and cache images
    
    static let shared = ImageDownloader()
    
    fileprivate var imageDownloadingTasks: [String: URLSessionDataTask] = [:]
    
    fileprivate let imageCache = NSCache<AnyObject, AnyObject>()
    typealias ImageDownloadCompletionHandler =  (_ image:UIImage?, _ uniqueId:String, _ error:Error?) -> ()
    
    private init()
    {
        
    }
    
    func downloadImage(fromURL urlString: String, uniqueId: String, completion: @escaping ImageDownloadCompletionHandler)
    {
        if imageDownloadingTasks[uniqueId] != nil
        {
            //Already op is in progress
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            //Image is taken from cache
            completion(imageFromCache, uniqueId, nil)
            return
        }
        
        if let url = URL(string: urlString)
        {
            let request = URLRequest(url: url)
            let dataTask = NetworkingManager.sharedManager.startNetworkFetch(withURLRequest: request) { (data, response, error) in
                self.imageDownloadingTasks.removeValue(forKey: uniqueId)
                if data != nil, error == nil
                {
                    if let image = UIImage(data: data!)
                    {
                        self.imageCache.setObject(image, forKey: urlString as AnyObject)
                        completion(image, uniqueId, nil)
                    }
                    else {
                        completion(nil, uniqueId, nil)
                    }
                }
                else {
                    completion(nil, uniqueId, error)
                }
            }
            imageDownloadingTasks[uniqueId] = dataTask
        }
    }
    
    func cancelImageOperation(forUniqueId uniqueID: String)
    {
        if let dataTask = imageDownloadingTasks[uniqueID]
        {
            dataTask.cancel()
        }
    }
    
    func image(fromUrlString urlString: String) -> UIImage?
    {
        var image: UIImage?
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
        }
        return image
    }
    
    func refreshCache()
    {
        imageCache.removeAllObjects()
    }
}
