//
//  Country.swift
//  HellQuiz
//
//  Created by Santanu Barman on 20/06/25.
//

struct Country: Codable {
    let name: CountryName
    let capital: [String]?

    struct CountryName: Codable {
        let official: String
    }
}

