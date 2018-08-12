//
//  APIController.swift
//  TVGuide
//
//  Created by Rizianne Veluz on 12/08/2018.
//  Copyright © 2018 Rizianne Veluz. All rights reserved.
//

import Foundation
import os

struct APIController {

    private static let mainApiUrl = "http://www.whatsbeef.net/wabz/guide.php?start=1"
    private static let extraDetailsApiUrl = "http://www.omdbapi.com/?apikey=1b59bf09&&type=series&plot=full&t="

    static func getSchedule(completionHandler: @escaping (_ shows: [Show]) -> Void) {
        let url = URL.init(string: mainApiUrl)!

        startTaskForUrl(url) { data in
            let decoder = JSONDecoder()
            do {
                let apiResponse = try decoder.decode(APIResponse.self, from: data!)
                completionHandler(apiResponse.results)
            }
            catch {
                os_log("Failed to decode API response", log: .default, type: .error)
            }
        }
    }
    
    static func getExtraDetailsForShow(_ title: String, completionHandler: @escaping (_ details: ShowExtraDetails) -> Void) {
        let url = URL.init(string: extraDetailsApiUrl + title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        startTaskForUrl(url) { data in
            let decoder = JSONDecoder()
            do {
                let apiResponse = try decoder.decode(ShowExtraDetails.self, from: data!)
                completionHandler(apiResponse)
            }
            catch {
                os_log("Failed to decode API response", log: .default, type: .error)
            }
        }
    }
    
    static func getImageFromUrl(_ url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        startTaskForUrl(url) { data in
            completionHandler(data)
        }
    }
    
    private static func startTaskForUrl(_ url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                os_log("Failed to retrieve data from API", log: .default, type: .error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                os_log("HTTP error", log: .default, type: .error)
                return
            }
            
            completionHandler(data)
        }
        task.resume()
    }
}
