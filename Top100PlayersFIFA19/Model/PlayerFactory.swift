//
//  PlayerFactory.swift
//  Top100PlayersFIFA19
//
//  Created by Omar Aldair Romero Pérez on 11/29/18.
//  Copyright © 2018 Omar Aldair Romero Pérez. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class PlayerFactory{
    
    
    let url: String
    var playersArray = [PlayerModel]()
    
    init(url: String) {
        self.url = url
        self.scrapeURL()
    }
    
    // Función para hacer la petición a la url y traer el html en forma de string
    func scrapeURL(){
        
        Alamofire.request(self.url).responseString { (response) in
            
            if response.result.isSuccess{
                
                if let htmlString = response.result.value{
                    self.parseHTML(html: htmlString)
                }
            }
        }
    }
    
    
    // Función para parsear la información del html traído anteriormente
    func parseHTML(html: String){
        
        do{
            
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
        
            for ironpages in doc.css("iron-pages"){
                
                for div in ironpages.css("div"){
                    
                    if div["class"] == "eas-tabs_section"{
                        
                        for section in div.css("section"){
                            
                            for div in section.css("div"){
                                
                                // Variables
                                var teamName : String?
                                var playerName : String?
                                var imageURL: String?
                                
                                
                                // Obtener el nombre del equipo
                                for h4 in div.css("h4"){
                                    if let team = h4.text{
                                        teamName = team
                                        break
                                    }
                                    
                                }
                                
                                // Obtener el nombre y lugar del jugador
                                for h2 in div.css("h2"){
                                    if let name = h2.text{
                                        playerName = name
                                        break
                                    }
                                    
                                }
                                
                                // Obtener la url de la imagen de la carta del jugador
                                for a in div.css("a"){
                                    if let image = a["href"]{
                                        imageURL = image
                                        break
                                    }
                                    
                                }
                                
                                // Si no llegaron nulas, entonces significa que podemos construir el objeto y agregarlo al array
                                if let team = teamName, let name = playerName, let image = imageURL{
                                    
                                    let model = PlayerModel(teamName: team, playerName: name, cardImageURL: "https:\(image)")
                                    self.playersArray.append(model)
                                    
                                    NotificationCenter.default.post(name: NSNotification.Name("PlayerUpdate"), object: nil) // Notificar al controller que se agregó un nuevo elemento
                                    
                                    print("Count: \(self.playersArray.count)")
                                    
                                }else{
                                    
                                    print("No se pudo crear")
                                    
                                }
                                
                                // Ordenar el array para que aparezca en el orden correcto por top 100 a 1
                                self.playersArray = self.playersArray.sorted(by: { (p1: PlayerModel, p2: PlayerModel) -> Bool in
                                    return p1.playerName > p2.playerName
                                })
                                
                                

                            }
                        }
                    }
                }
            }
            
            
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
}
