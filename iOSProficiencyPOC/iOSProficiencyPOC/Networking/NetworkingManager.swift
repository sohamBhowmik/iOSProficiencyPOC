//
//  NetworkingManager.swift
//  iOSProficiencyPOC
//
//  Created by Soham Bhowmik on 05/09/19.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class NetworkingManager
{
    static let sharedManager = NetworkingManager()
    typealias CompletionHandler =  (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> ()
    
    private init()
    {
        
    }
    
    func fetchListingData(onCompletion completion: @escaping CompletionHandler)
    {
        if let url = URL(string: Constants.URL.listingURL) {
            let request = URLRequest(url: url)
            _ = startNetworkFetch(withURLRequest: request, completion: completion)
        }
    }
    
    func startNetworkFetch(withURLRequest request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionDataTask
    {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
        dataTask.resume()
        return dataTask
    }
}
