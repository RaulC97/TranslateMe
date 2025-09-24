# Project 6 - *TranslateMe*

Submitted by: **Raul Chavez Z-23688680**

**TranslateMe** is an app that takes in a word or phrase from a source language, and translates it into target language 

Time spent: **8** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] Users open the app to a TranslationMe home page with a place to enter a word, phrase or sentence, a button to translate, and another field that should initially be empty
- [x] When users tap translate, the word written in the upper field translates in the lower field. The requirement is only that you can translate from one language to another.
- [x] A history of translations can be stored (in a scroll view in the same screen, or a new screen)
- [x] The history of translations can be erased
 
The following **optional** features are implemented:

- [x] Add a variety of choices for the languages
- [ ] Add UI flair

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Project_6_Demo](https://github.com/user-attachments/assets/d4ce7bc5-64e0-4ae7-b233-7ad9380bc55b)


In this demonstration, when you open the app you can see four main things: English and Spanish options, Textfield that ask to enter text, a button that says translate me, 
an empty textbox and a navigation link that says list of tranlations

The two languages, left to right, are the source and traget langueges. There are four options, English, Spanish, French and German.

After selecting the langueges you want to translate, you must enter a text in the source languege. After entering a text, pressing the button, "translate me", the following text 
box will be updated with the translated text in the target languege.

After pressing the "translate me" button, the translated word is saved in FirebaseFirestore. When you click on the "list of translations", you will be navigated to a different screen with 
the translated text. There is also a "clear all translations" button, that clears all the translations from FirebaseFirestore database.

## Notes

Some of the challenges I faced in this project was saving, retrieving and deleting the translations, more so the deleting part.

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
