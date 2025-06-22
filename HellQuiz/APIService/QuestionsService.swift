//
//  QuestionsService.swift
//  HellQuiz
//
//  Created by Santanu Barman on 20/06/25.
//

import Foundation
class QuestionService {
    static let shared = QuestionService()

    func fetchQuizQuestions(completion: @escaping (Result<[Question], Error>) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v3.1/all?fields=name,capital") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)

                // Filter countries with capitals
                let validCountries = countries.filter { $0.capital?.isEmpty == false }

                // Extract all capitals for randomizing
                let allCapitals = validCountries.compactMap { $0.capital?.first }

                // Limit to 10 random quiz questions
                let selectedCountries = validCountries.shuffled().prefix(10)

                var questions: [Question] = []

                for (index, country) in selectedCountries.enumerated() {
                    guard let correctCapital = country.capital?.first else { continue }

                    // Generate 3 random wrong options
                    var options = Set<String>()
                    options.insert(correctCapital)
                    while options.count < 4 {
                        if let random = allCapitals.randomElement(), random != correctCapital {
                            options.insert(random)
                        }
                    }

                    let shuffledOptions = Array(options).shuffled()
                    let correctIndex = shuffledOptions.firstIndex(of: correctCapital) ?? 0

                    let question = Question(
                        text: "What is the capital of \(country.name.official)?",
                        options: shuffledOptions,
                        correctIndex: correctIndex
                    )

                    questions.append(question)
                }
                
                print(questions);

                DispatchQueue.main.async {
                    completion(.success(questions))
                }

            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}


