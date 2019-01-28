//
//  Photo.swift
//  AlamofireExample
//
//  Created by Marta Boteller on 13/01/2019.
//  Copyright © 2019 Marta Boteller. All rights reserved.
//

import Foundation


class Photo: NSObject, Codable {
    
    var group = ""
    var eighteenplus = ""
    var iconfarm = ""
    var iconserver = ""
    var members = ""
    var name = ""
    var nsid = ""
    var pool_count = ""
    var privacy = ""
    var topic_count = ""
    var page = ""
    var pages = ""
    var perpage = ""
    var total = ""
    
    //Used to make Place codable
    enum PhotoKeys: String, CodingKey {
        case group = "group"
        case eighteenplus = "eighteenplus"
        case iconfarm = "iconfarm"
        case iconserver = "iconserver"
        case members =  "members"
        case name = "name"
        case nsid = "nsid"
        case pool_count = "pool_count"
        case privacy = "privacy"
        case topic_count = "topic_count"
        case page = "page"
        case pages = "pages"
        case perpage = "perpage"
        case total = "total"
    }
    
    init(group: String, eighteenplus: String, iconfarm: String,iconserver: String,members: String, name: String, nsid:String, pool_count: String, privacy: String, topic_count: String, page: String, pages: String, perpage: String, total: String) {
        self.group = group
        self.eighteenplus = eighteenplus
        self.iconfarm = iconfarm
        self.iconserver = iconserver
        self.members = members
        self.name = name
        self.nsid = nsid
        self.pool_count = pool_count
        self.privacy = privacy
        self.topic_count = topic_count
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
      
    }
    
   
}
