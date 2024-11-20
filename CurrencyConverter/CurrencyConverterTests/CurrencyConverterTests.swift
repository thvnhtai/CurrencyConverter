import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {
    
    var viewModel: CurrencyConverterViewModel!
    
    override func setUpWithError() throws {
        viewModel = CurrencyConverterViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testValidConversion() {
        viewModel.exchangeRates = ["USD": 1.0, "EUR": 0.85]
        viewModel.selectedFromCurrency = "USD"
        viewModel.selectedToCurrency = "EUR"
        viewModel.inputAmount = "100"

        viewModel.convert()

        XCTAssertEqual(viewModel.convertedAmount, "85.00", "Conversion result is incorrect")
    }

    func testInvalidInput() {
        viewModel.inputAmount = "invalid_amount"
        viewModel.convert()

        XCTAssertTrue(viewModel.convertedAmount.isEmpty, "Converted amount should be empty for invalid input")
        XCTAssertEqual(viewModel.errorMessage, "Invalid input. Please enter a valid number.", "Expected error message for invalid input")
    }

    
    func testNetworkErrorHandling() {
        viewModel.exchangeRates = [:]
        viewModel.selectedFromCurrency = "USD"
        viewModel.selectedToCurrency = "EUR"
        viewModel.inputAmount = "100"

        viewModel.convert()

        XCTAssertEqual(viewModel.convertedAmount, "", "Converted amount should be empty when exchange rates are unavailable")
        XCTAssertEqual(viewModel.errorMessage, "Exchange rate data is unavailable.", "An error message should be set when exchange rates are unavailable")
    }

}
