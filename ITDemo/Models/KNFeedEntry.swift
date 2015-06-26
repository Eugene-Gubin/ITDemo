//
//  KNFeedEntry.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation

struct KNFeedEntry : Printable {
    var title: String!
    var desc: String!
    var pubDate: String!
    var author: String!
    var link: String!
    
    var description: String {
        return "title \(title) pubDate \(pubDate) author \(author) link \(link)"
    }
}