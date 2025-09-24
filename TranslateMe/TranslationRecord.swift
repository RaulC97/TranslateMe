//
//  TranslationRecord.swift
//  TranslateMe
//
//  Created by Raul Chavez on 11/11/24.
//

import SwiftUI

struct TranslationRecord: Identifiable, Codable {
    
    var id: String
    let originalText: String
    let translationText: String
    let timestamp: Date
    
}


