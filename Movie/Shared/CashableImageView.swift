//
//  CashableImageView.swift
//  Movie
//
//  Created by Javad on 11.09.22.
//

import UIKit

let cache = NSCache<AnyObject, AnyObject>()

class CashableImageView: UIImageView {
   
   private var imageURL: URL?
    
    func  loadImageWith(url : URL){
        if let cachedImage = getImage(with: url.lastPathComponent.components(separatedBy: ".").first ?? ""){
            //if cached image exist, use it
            self.image = cachedImage
        }else{
            //try to dowload and cach it
            imageURL = url
            image = nil
            DispatchQueue.global(qos: .background).async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

                    if let imageData = data, let imageToCache = UIImage(data: imageData){
                        let img = imageToCache
                        
                        if self.imageURL == url {
                            DispatchQueue.main.async {
                                self.image = img
                            }
                        }
                        
                        DispatchQueue.global().async {
                            cache.setObject(img, forKey: url as AnyObject)
                            self.saveImage(img, filename: url.lastPathComponent.components(separatedBy: ".").first ?? "")
                    }
                    } else {
                        //if dowload failed provid a place holder as default
                        DispatchQueue.main.async {
                            self.image = UIImage(named: "Logo")
                    }
                }
            }
        }
    }
    
    private var fileCache: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
   private func saveImage(_ image: UIImage, filename: String) {
        let url = fileCache.appendingPathComponent(filename)
        guard let data = image.pngData() else {
            return
        }
        try? data.write(to: url, options: [])
    }
    
   private func getImage(with filename: String) -> UIImage? {
        let url = fileCache.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
