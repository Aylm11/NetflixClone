//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Ali YILMAZ on 9.04.2022.
//



import Foundation

struct YoutubeSearchResponse : Codable{
    
    let items : [VideoElement]
}

struct VideoElement:Codable {
    let id: IdVideoElement
}


struct IdVideoElement : Codable {
    let kind : String
    let videoId : String
}
