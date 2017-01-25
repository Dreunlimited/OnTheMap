//
//  ParseAPI.swift
//  OnTheMap
//
//  Created by Dandre Ealy on 1/20/17.
//  Copyright © 2017 Dandre Ealy. All rights reserved.
//

import Foundation

struct Parse {
    static let helper = Parse()
    
    struct PARSE {
        static let ApiScheme = "https://"
        static let ApiHost = "parse.udacity.com/parse/classes/StudentLocation"
        static let BASEURL = ApiScheme + ApiHost
    }
    
    struct ParseParameterKeys {
        static let appId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
 


}
