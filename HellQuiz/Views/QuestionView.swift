//
//  QuestionView.swift
//  HellQuiz
//
//  Created by Santanu Barman on 18/06/25.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizVM: QuizViewModel

    var body: some View {
        VStack(spacing: 20) {
            if !quizVM.questions.isEmpty {
                let questionNumber = quizVM.currentIndex + 1
                let total = quizVM.questions.count

                Text("Question \(questionNumber) of \(total)")
                    .font(.headline)
                    .font(.headline)
            }
            if let question = quizVM.currentQuestion {
                Text(question.text)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                ForEach(0..<question.options.count, id: \.self) { index in
                    let optionText = question.options[index]
                    let isSelected = index == quizVM.selectedIndex
                    let isCorrect = index == question.correctIndex

                    Button(action: {
                        if !quizVM.isAnswerSubmitted {
                            quizVM.selectedIndex = index
                        }
                    }) {
                        HStack {
                            Text(optionText)
                            Spacer()
                            if quizVM.isAnswerSubmitted {
                                if isCorrect {
                                    Image(systemName: "checkmark.circle").foregroundColor(.green)
                                } else if isSelected {
                                    Image(systemName: "xmark.circle").foregroundColor(.red)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                        )
                    }
                    .disabled(quizVM.isAnswerSubmitted)
                }
            } else {
                ProgressView("Loading...")
            }

//            ProgressView(value: quizVM.progress)

            if quizVM.isAnswerSubmitted {
                Button("Next", action: quizVM.nextQuestion)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Button("Submit", action: quizVM.submitAnswer)
                    .disabled(quizVM.selectedIndex == nil)
                    .padding()
                    .background(quizVM.selectedIndex != nil ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
