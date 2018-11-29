//
//  PlayerModel.swift
//  Top100PlayersFIFA19
//
//  Created by Omar Aldair Romero Pérez on 11/29/18.
//  Copyright © 2018 Omar Aldair Romero Pérez. All rights reserved.
//

import Foundation

class PlayerModel{
    
    var teamName: String
    var playerName: String
    var cardImageURL: String
    
    init(teamName: String, playerName: String, cardImageURL: String) {
        self.teamName = teamName
        self.playerName = playerName
        self.cardImageURL = cardImageURL
    }
    
    /*init() {
        self.teamName = ""
        self.playerName = ""
        self.cardImageURL = ""
    }*/
}
