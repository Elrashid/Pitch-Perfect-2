//
//  RecordedAudio.swift
//  Pitch Perfect 2
//
//  Created by mohamed elrashid on 1/16/16.
//  Copyright © 2016 my name or my camopany Name. All rights reserved.
//

import Foundation
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    init(_filePathUrl: NSURL,_title: String) {
      filePathUrl = _filePathUrl
      title = _title
    }
}
