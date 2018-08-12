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

    static func getSchedule(completionHandler: @escaping (_ shows: [Show]) -> Void) {
        let url = URL.init(string: "http://www.whatsbeef.net/wabz/guide.php?start=1")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                os_log("Failed to retrieve data from API", log: .default, type: .error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                os_log("HTTP error", log: .default, type: .error)
                return
            }

            let decoder = JSONDecoder()
            do {
                let apiResponse = try decoder.decode(APIResponse.self, from: data!)
                completionHandler(apiResponse.results)
            }
            catch {
                os_log("Failed to decode API response", log: .default, type: .error)
            }
        }
        task.resume()
    }
}
