//
//  BookService.swift
//  CoolBooks
//
//  Created by user197181 on 4/8/21.
//

import Foundation

enum BookCallingError: Error {
    case problemGeneratingURL
    case problemGettingDataFromAPI
    case problemDecodingData
}

class BookService {
    
    private let urlString = "https://run.mocky.io/v3/bef73c4c-291d-4d4d-81cd-474df1c40314"
    
    func getBooks(completion: @escaping ([Book]?, Error?) -> ()) {
            guard let url = URL(string: self.urlString) else {
                DispatchQueue.main.async { completion(nil, BookCallingError.problemGeneratingURL) }
                return
        }
                
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async { completion(nil, BookCallingError.problemGettingDataFromAPI) }
                    return
                }
                
                do {
                    let bookResult = try JSONDecoder().decode(BookResult.self, from: data)
                    DispatchQueue.main.async { completion(bookResult.books, nil) }
                } catch (let error) {
                    print(error)
                    DispatchQueue.main.async { completion(nil, BookCallingError.problemDecodingData) }
                }
                                                        
            }
            task.resume()
        }
}
    


