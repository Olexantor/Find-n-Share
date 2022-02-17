//
//  NetworkManager.swift
//  Find'n'Share
//
//  Created by Александр on 17.02.2022.
//
import Alamofire
import Foundation

enum fetchErrors: Error {
    case invalidUrl
    case missingData
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchLinksWith(query: String, completion: @escaping (Result<[URL], Error>) -> Void) {
        let url = urlSerpapi + query + serpapiKey
        guard let supplementedURL = url.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {
            completion(.failure(fetchErrors.invalidUrl))
            return
        }
        AF.request(supplementedURL).validate().response { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        completion(.failure(fetchErrors.missingData))
                        return
                    }
                    let json = try JSONDecoder().decode(PictureModel.self, from: data)
                    let linksToPictures: [URL] = json.imagesResults.compactMap { image in
                        if let  url = URL(string: image.original) {
                            return url
                        }
                        return nil
                    }
                    completion(.success(linksToPictures))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    private init() {}
}

