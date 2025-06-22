//
//  Questions.swift
//  HellQuiz
//
//  Created by Santanu Barman on 18/06/25.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctIndex: Int
}


