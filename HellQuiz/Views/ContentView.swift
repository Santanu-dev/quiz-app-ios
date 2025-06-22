//
//  ContentView.swift
//  HellQuiz
//
//  Created by Santanu Barman on 18/06/25.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var quizVM = QuizViewModel()

    var body: some View {
        if quizVM.showResult {
            ResultView()
                .environmentObject(quizVM)
        } else {
            QuestionView()
                .environmentObject(quizVM)
        }
    }
}

#Preview {
    ContentView()
}

