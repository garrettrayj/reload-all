//
//  TabTimers.swift
//  SafariExtension
//
//  Created by Garrett Johnson on 9/20/18.
//  Copyright © 2018 DevSci. All rights reserved.
//

import Foundation
import SafariServices

class ReloadPages {
    static let shared = ReloadPages()
    var pages = Set<SFSafariPage>()
}
