# Currency Converter App

## Description
The **Currency Converter** app allows users to input an amount and select currencies to convert from and to. It fetches live exchange rates from a public API and performs the conversion in real-time, displaying the converted amount to the user.

### Key Features:
- Input an amount and select currencies to convert from and to.
- Fetch live exchange rates from a public API (e.g., ExchangeRatesAPI).
- Display the converted amount on the screen.
- Basic error handling for network failures and invalid inputs.

## Application Structure
The app is structured into multiple components following the **MVVM** (Model-View-ViewModel) architecture:

- **CurrencyConverterApp**: The entry point of the app.
- **Models**: Contains the `CurrencyRateResponse` model for mapping API responses.
- **ViewModels**: Contains the `CurrencyConverterViewModel` responsible for handling the business logic, API calls, and state management.
- **Views**: The user interface components.
- **Assets**: Contains assets used by the app, such as images and icons.
- **PreviewContent**: Includes preview data for SwiftUI previews.

## Installation and Running the App
### Requirements:
- Xcode (latest version).
- A Mac running macOS.

### Steps to Run:
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/thvnhtai/CurrencyConverterApp.git
2. Open the project in Xcode.
3. Build and run the app on a simulator or physical device.

## Notes:
- The app fetches live exchange rates from a public API. Ensure you have a working internet connection.
- The app uses basic error handling for cases like network failures, invalid input amounts, and unavailable exchange rates.

## Challenges Faced:
- Integrating the currency exchange API and handling edge cases like network failures.
- Ensuring the app works smoothly across various screen sizes and orientations.

## License:
This project is licensed under the MIT License - see the LICENSE file for details.
