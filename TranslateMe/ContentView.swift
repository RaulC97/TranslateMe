//
//  ContentView.swift
//  TranslateMe
//
//  Created by Raul Chavez on 11/6/24.
//

import SwiftUI

struct ContentView: View {
    
    // These variables will help us store the strings of orignal text and translated text
    @State private var orignalText: String = ""
    @State private var translatedText: String = ""
    @State private var translationManager = TranslationManager()
    
    let languages = ["English", "Spanish", "French", "German"]
    
    let languageCodes: [String: String] = [
        "English": "en",
        "Spanish": "es",
        "French": "fr",
        "German": "de"
    ]
    
    @State private var sourceLanguage: String = "English"
    @State private var targetLanguage: String = "Spanish"
    
    
    var body: some View {
        
        // Navigation link to help us come back to the main screen from list of translated words
        NavigationStack {
            
            // Placeholder for when we add selecting different languages
            HStack {
                
                Picker("Select Soure Language", selection: $sourceLanguage) {
                    ForEach(languages, id: \.self) { language in
                        Text(language).tag(language)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                Text(" to ")
                Picker("Select Target Language", selection: $targetLanguage) {
                    ForEach(languages, id: \.self) { language in
                        Text(language).tag(language)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
            }
            .padding(.top, 70)
            
            // Create VStack to hold textfield, translate button, text for translated screen, and a button to see a list of translated words
            VStack(spacing:15){
                
                // Text field to hold the original text
                TextField("Enter your orignal text here", text: $orignalText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                
                // Button that when pressed, will translate the orinal text, and display the translated text into the next part
                Button("Translate me") {
                    
                    //translatedText = "The button has been pressed "
                    Task {
                        await fetchTranslation()
                        
                        
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundStyle(.white)
                .cornerRadius(20)
                
                // Holds the translated text and displays the text
                Text(translatedText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .frame(height: 150)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 3))
                
                
                NavigationLink("Click here for a list of translations", destination: TranslationHistoryView(translationManager: translationManager))
                
            }
            .navigationTitle("Translate me")
            .padding()
            
            
            Spacer()

            
        }
    }
    
    private func fetchTranslation() async {
        
        let sourceCode = languageCodes[sourceLanguage] ?? "en"
        let targetCode = languageCodes[targetLanguage] ?? "es"
        
        var components = URLComponents(string: "https://api.mymemory.translated.net/get")!
        
        components.queryItems = [
            URLQueryItem(name:"q", value: orignalText),
            URLQueryItem(name: "langpair", value: "\(sourceCode)|\(targetCode)")
        ]
        
        print(components)
        let url = components.url!
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let translationResponse = try JSONDecoder().decode(TranslationResponse.self, from: data)
            
            let translation = translationResponse.responseData
            
            self.translatedText = translation.translatedText
            
            try await translationManager.saveTranslation(originalText: orignalText, translatedText: translatedText)
            
            await translationManager.fetchTranslations()
            
            print(translatedText)
        } catch {
            
            print(error.localizedDescription)
        }
        
    }
    
}

#Preview {
    ContentView()
}
