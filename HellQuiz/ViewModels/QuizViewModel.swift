//
//  QuizViewModel.swift
//  HellQuiz
//
//  Created by Santanu Barman on 18/06/25.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    init() {
        fetchQuestions()
    }
    func fetchQuestions() {
            isLoading = true
            errorMessage = nil

            QuestionService.shared.fetchQuizQuestions { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false

                    switch result {
                    case .success(let fetchedQuestions):
                        self?.questions = fetchedQuestions

                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }
        }
//    @Published var questions: [Question] = [
//        Question(text: "What is the capital of France?", options: ["Paris", "London", "Berlin", "Madrid"], correctIndex: 0),
//        // Add 9 more sample questions here
//    ]
    @Published var currentIndex = 0
    @Published var selectedIndex: Int? = nil
    @Published var score = 0
    @Published var isAnswerSubmitted = false
    @Published var showResult = false

    var currentQuestion: Question? {
        guard questions.indices.contains(currentIndex) else { return nil }
        return questions[currentIndex]
    }

    func submitAnswer() {
        if selectedIndex == currentQuestion?.correctIndex {
            score += 10
        }
        isAnswerSubmitted = true
    }

    func nextQuestion() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
            selectedIndex = nil
            isAnswerSubmitted = false
        } else {
            showResult = true
        }
    }

    func restart() {
        currentIndex = 0
        score = 0
        selectedIndex = nil
        isAnswerSubmitted = false
        showResult = false
    }

    var progress: Double {
        Double(currentIndex + 1) / Double(questions.count)
    }

    var percentageScore: Int {
        (score * 100) / (questions.count * 10)
    }
}


