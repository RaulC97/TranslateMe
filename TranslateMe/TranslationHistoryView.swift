//
//  TranslationHistoryView.swift
//  TranslateMe
//
//  Created by Raul Chavez on 11/11/24.
//

import SwiftUI
import FirebaseFirestore

struct TranslationHistoryView: View {
    
    @Bindable var translationManager: TranslationManager
    
    var body: some View {
        Form {
            // Ensure translations are fetched before displaying
            if translationManager.translations.isEmpty {
                Text("No translations available.")
            } else {
                ForEach(translationManager.translations) { translation in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(translation.translationText)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await translationManager.fetchTranslations() // Ensure translations are fetched
            }
            
        }
        
        Button("Clear all Translations") {
            
            Task {
                do {
                    try await translationManager.deleteAllTranslations()
                    
                    await translationManager.fetchTranslations()
                } catch {
                    print("\(error)")
                }
            }
        }
        .frame(width: 200,height: 50)
        .background(.red)
        .foregroundStyle(.white)
        .cornerRadius(10)
        
    }
}


