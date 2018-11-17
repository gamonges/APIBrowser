//
//  SampleModel.swift
//  APIBrowser
//
//  Created by 蒲生廣人 on 2018/11/15.
//  Copyright © 2018 蒲生廣人. All rights reserved.
//

import Foundation

struct SampleModel: Codable{
    var date: String = ""
    var link: String = ""
    var title: SampleTitleModel = SampleTitleModel()
    
    struct SampleTitleModel: Codable {
        var rendered: String = ""
    }
    
}
