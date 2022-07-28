//
//  Extension.swift
//  PelisApp
//
//  Created by sebastian abarzua on 15-07-22.
//

import UIKit

extension UIImageView {
    
    func imageUrlServer(urlString: String, placeHolderImage: UIImage){
        
        if self.image == nil {
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}
