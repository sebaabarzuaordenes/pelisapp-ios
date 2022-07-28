//
//  ManagerConections.swift
//  PelisApp
//
//  Created by sebastian abarzua on 15-07-22.
//

import Foundation
import RxSwift

class ManagerConections{
    
    func getPopularMovies() -> Observable<[Movie]>{
        
        return Observable.create { observer in
    
        let session = URLSession.shared
        let request = URLRequest(url: URL(string: Constans.URL.main+Constans.EndPoint.urlPopularListMovies+Constans.apyKey)!)
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200{
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: data)
                    
                    observer.onNext(movies.listMovies)
                } catch let error{
                    observer.onError(error)
                    print("erro parseo movies list  ")
                }
            }
            else if response.statusCode == 401 {
                print("error 401")
            }
            observer.onCompleted()
            }.resume()
        
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getDetailMovie(movieId: String) -> Observable<MovieDetail>{
        return Observable.create { observer in
    
        let session = URLSession.shared
        let request = URLRequest(url: URL(string: Constans.URL.main+Constans.EndPoint.urlDetailMovie+movieId+Constans.apyKey)!)
        print(request)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200{
                do {
                    let decoder = JSONDecoder()
                    let detailMovie = try decoder.decode(MovieDetail.self, from: data)
                    observer.onNext(detailMovie)
                } catch let error{
                    observer.onError(error)
                    print("error parseo detalle peliculas")
                }
            }
            else if response.statusCode == 401 {
                print("error 401")
            }
            observer.onCompleted()
            }.resume()
        
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    
    func GetImageForServer(urlString: String) -> Observable<UIImage>{
        return Observable.create { observer in
            let placeHolderImage = UIImage(named: "claqueta-de-cine")!
            
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { data, response, error  -> Void in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if error != nil{
                    print(error ?? " no error")
                    return
                }
                if response.statusCode == 200{
                    guard let image = UIImage(data: data) else {return}
                    observer.onNext(image)
                } else {
                    observer.onNext(placeHolderImage)
                }
                observer.onCompleted()
            }).resume()
            
            return Disposables.create()
        }
    }
}
 
