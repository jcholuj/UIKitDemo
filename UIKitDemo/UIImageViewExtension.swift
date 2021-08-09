//
//  UIImageViewExtension.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 09/08/2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(urlString : String) {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
              self.image = imageFromCache as? UIImage
              return
        }
        
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: urlString as AnyObject)
                self?.image = image
            }
        }
    }
}
