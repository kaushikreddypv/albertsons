//
//  ContentListModel.swift
//  Assignment
//
//  Created by Venkata, Kaushik on 10/13/21.
//

import Foundation
import UIKit

// MARK: - ContentModel
struct ContentModel: Codable {
    let sf: String?
    let lfs: [LF]?
}

// MARK: - LF
struct LF: Codable {
    let lf: String?
    let freq, since: Int?
    let vars: [LF]?
}
