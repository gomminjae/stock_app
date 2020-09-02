//
//  APIManager.swift
//  stock_app
//
//  Created by 권민재 on 2020/08/27.
//  Copyright © 2020 gommj_Dev. All rights reserved.
//

import Foundation



class APIManager {
    
    static func getSearchResults(_ term: String, display: Int, completion: @escaping ([News]) -> Void) {
        
        //guard let url: URL = URL(string: "https://openapi.naver.com/v1/search/news.json?/query=\(term)") else { return }
        let requestURL =  "https://openapi.naver.com/v1/search/news.json?query=\(term)&sort=\("sim")&display=\(display)"
        let encoding = requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let xurl = URL(string: encoding)!
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: xurl)
        request.httpMethod = "GET"
        //HTTP header
        request.addValue("tRbXfUU54efrzbzzL_qR", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("qX3ZuDiOob", forHTTPHeaderField: "X-Naver-Client-Secret")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")


        let dataTask = session.dataTask(with: request) { (data, response, error) in
            let successRange = 200..<300
            
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode,
                successRange.contains(statusCode) else {
                    completion([])
                    print("invalud range")
                    return  }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            let news = APIManager.parseNews(resultData)
            completion(news)
        }
        
        dataTask.resume()
    }
    
    
    
    static func parseNews(_ data: Data) -> [News] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(Response.self, from: data)
            let news = response.news
            return news
        }catch let error {
            print("--> error: \(error.localizedDescription)")
            return []
        }
    }
}
