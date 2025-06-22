//
//  ResultsView.swift
//  HellQuiz
//
//  Created by Santanu Barman on 18/06/25.
//

import Foundation
import SwiftUI

struct ResultView: View {
    @EnvironmentObject var quizVM: QuizViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz Completed!")
                .font(.largeTitle)

            Text("Score: \(quizVM.score)/\(quizVM.questions.count * 10)")
                .font(.title)

            Text("Accuracy: \(quizVM.percentageScore)%")

            Button("Restart") {
                quizVM.restart()
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
