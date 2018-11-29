//
//  Extension.swift
//  Top100PlayersFIFA19
//
//  Created by Omar Aldair Romero Pérez on 11/29/18.
//  Copyright © 2018 Omar Aldair Romero Pérez. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func downloadedFrom(link: String, contentMode: UIView.ContentMode = .scaleAspectFit){
        
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url)
        
    }
    
    // Función de extensión a una UIImageView para a través de un URL descargar una imagen y al mismo tiempo asignarla a esa UIImageView
    func downloadedFrom(url: URL, contentMode: UIView.ContentMode = .scaleAspectFit){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
