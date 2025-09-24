//
//  TranslationManager.swift
//  TranslateMe
//
//  Created by Raul Chavez on 11/11/24.
//

import SwiftUI
import FirebaseFirestore
import Foundation

@Observable
class TranslationManager {
    
    private let dataBase = Firestore.firestore()
    
    var translations: [TranslationRecord] = []
    
    init() {
        
        fetchTranslations()
        
    }
    
    func saveTranslation(originalText: String, translatedText: String) async throws {
        
        let translation = TranslationRecord(
            id: UUID().uuidString,
            originalText: originalText,
            translationText: translatedText,
            timestamp: Date()
        )
        
        let data: [ String: Any] = [
            "id": translation.id,
            "originalText": translation.originalText,
            "translatedText": translation.translationText,
            "timestamp": translation.timestamp
        ]
        
        try await dataBase.collection("translations").document(translation.id).setData(data)
    }
    
    func fetchTranslations() {
        
        dataBase.collection("translations")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { [weak self] querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    self?.translations = []
                    return
                }
                
                let translations = documents.compactMap { document -> TranslationRecord? in
                    
                    let data = document.data()
                    
                    guard
                        let id = data["id"] as? String,
                        let originalText = data["originalText"] as? String,
                        let translatedText = data["translatedText"] as? String,
                        let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() else {
                        return nil
                    }
                    
                    return TranslationRecord(
                        id: id,
                        originalText: originalText,
                        translationText: translatedText,
                        timestamp: timestamp
                    )
                }
                
                print("Fetched translations: \(translations)")
                self?.translations = translations
                
            }
        
    }
    
    
    func deleteAllTranslations() async throws {
        
        let querySnapshot = try await dataBase.collection("translations").getDocuments()
        
        let batch = dataBase.batch()
        
        for document in querySnapshot.documents {
            
            batch.deleteDocument(document.reference)
            
        }
        
        try await batch.commit()
        
        
    }
    
    
    
    
}
