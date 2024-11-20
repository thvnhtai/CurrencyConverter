import Foundation

class CurrencyConverterViewModel: ObservableObject {
    @Published var inputAmount: String = ""
    @Published var convertedAmount: String = ""
    @Published var selectedFromCurrency: String = "EUR"
    @Published var selectedToCurrency: String = "USD"
    @Published var exchangeRates: [String: Double] = [:]
    @Published var errorMessage: String?

    private let apiUrl = "https://api.exchangeratesapi.io/v1/latest?access_key=6c7b24b720eaef21e08f7e96b3fe3a86"

    func fetchExchangeRates() {
        guard let url = URL(string: apiUrl) else {
            self.errorMessage = "Invalid URL"
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Network Error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(CurrencyRateResponse.self, from: data)
                    if decodedResponse.success {
                        self?.exchangeRates = decodedResponse.rates
                    } else {
                        self?.errorMessage = "Failed to fetch exchange rates"
                    }
                } catch {
                    self?.errorMessage = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }
        task.resume()
    }

    func convert() {
        guard let amount = Double(inputAmount) else {
            self.convertedAmount = ""
            self.errorMessage = "Invalid input. Please enter a valid number."
            return
        }
        
        guard let fromRate = exchangeRates[selectedFromCurrency],
              let toRate = exchangeRates[selectedToCurrency] else {
            self.convertedAmount = ""
            self.errorMessage = "Exchange rate data is unavailable."
            return
        }
        
        let result = (amount / fromRate) * toRate
        self.convertedAmount = String(format: "%.2f", result)
        self.errorMessage = nil
    }

}

