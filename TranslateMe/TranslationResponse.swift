//
//  TranslationResponse.swift
//  TranslateMe
//
//  Created by Raul Chavez on 11/8/24.
//

import SwiftUI

struct TranslationResponse: Codable {
    
    let responseData: Translation
    
}

struct Translation: Codable {
    
    let translatedText: String
    
}
