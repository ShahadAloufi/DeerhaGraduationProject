//
//  LocalizationExtension.swift
//  Derha
//
//  Created by shahadmufleh on 10/07/2022.
//

import Foundation

extension String {
    var localized: String {
        return localized(from: nil)
    }

    func localized(withSubstitutions substitutions: String...) -> String {
        return String(format: self.localized, arguments: substitutions)
    }

    func localized(from table: String?) -> String {
        let translatedString = getTranslatedString(fromTable: table)

        // No sense looking up the string in Release builds
        #if !DEBUG
            return translatedString
        #endif

        guard Locale.current.languageCode == "en" else {
            return translatedString
        }

  

        return translatedString
    }

    private func getTranslatedString(fromTable table: String?, inLanguage language: String) -> String {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
            let otherLanguageBundle = Bundle(path: path) {
            let otherLanguageString = getTranslatedString(fromTable: table, andBundle: otherLanguageBundle)

            return otherLanguageString
        }
        return self
    }

    private func getTranslatedString(fromTable table: String?, andBundle bundle: Bundle = Bundle.main) -> String {
        let translatedString = bundle.localizedString(forKey: self, value: self, table: table)

        return translatedString
    }
}
