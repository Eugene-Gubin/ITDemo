//
//  KNNYTParser.swift
//  ITDemo
//
//  Created by Eugene Gubin on 6/26/15.
//  Copyright (c) 2015 Evgeniy Gubin. All rights reserved.
//

import Foundation

class KNNYTParser: NSObject, NSXMLParserDelegate {
    
    private enum Node: String {
        case Item = "item"
        case Title = "title"
        case Desc = "description"
        case Date = "pubDate"
        case Author = "dc:creator"
        case Link = "guid"
    }
    
    private var entries: [KNFeedEntry] = []
    
    private var currentEntry: KNFeedEntry? = nil
    
    private var stringBuffer: String?
    
    @objc func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if let s = string, let buf = stringBuffer {
            stringBuffer = buf + s
        }
    }
    
    @objc func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        if let node = Node(rawValue: elementName) {
            switch node {
            case .Item:
                currentEntry = KNFeedEntry()
            default:
                stringBuffer = ""
            }
        }
    }
    
    @objc func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let node = Node(rawValue: elementName), let _ = currentEntry {
            switch node {
            case .Item:
                entries.append(currentEntry!)
                currentEntry = nil
            case .Title:
                currentEntry!.title = stringBuffer
            case .Desc:
                currentEntry!.desc = stringBuffer
            case .Date:
                currentEntry!.pubDate = stringBuffer
            case .Author:
                currentEntry!.author = stringBuffer
            case .Link:
                currentEntry!.link = stringBuffer
            }
            if node != .Item {
                stringBuffer = nil
            }
        }
    }
    
    static func asyncParseFromURL(url: String, callback: ([KNFeedEntry]? -> ())?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let result = self.parseFromURL(url)
            dispatch_async(dispatch_get_main_queue()) {
                callback?(result)
            }
        }
    }
    
    static func parseFromURL(url: String) -> [KNFeedEntry]? {
        
        if  let rssURL = NSURL(string: url),
            let parser = NSXMLParser(contentsOfURL: rssURL) {
                
                let delegate = KNNYTParser()
                parser.delegate = delegate
                if parser.parse() {
                    return delegate.entries
                }
        }
        return nil
    }
}