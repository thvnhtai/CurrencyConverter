import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 24) {

                    HStack(spacing: 24) {
                        Text("From:")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.bottom, 2)
                            .fontWeight(.bold)

                        Picker("", selection: $viewModel.selectedFromCurrency) {
                            ForEach(Array(viewModel.exchangeRates.keys), id: \.self) { currency in
                                Text(currency)
                                    .foregroundColor(.black)
                                    .font(.system(size: 12))
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).opacity(0.9))
                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)

                        Text("To:")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .padding(.bottom, 2)
                            .fontWeight(.bold)
                    
                        Picker("", selection: $viewModel.selectedToCurrency) {
                            ForEach(Array(viewModel.exchangeRates.keys), id: \.self) { currency in
                                Text(currency)
                                    .foregroundColor(.black)
                                    .font(.system(size: 12))
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).opacity(0.9))
                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                    }
                    .padding(.horizontal)

                    TextField("Enter amount", text: $viewModel.inputAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).opacity(0.8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 2)
                        )
                        .padding(.horizontal)

                    Button(action: {
                        viewModel.convert()
                    }) {
                        Text("Convert")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                            .shadow(color: Color.purple.opacity(0.5), radius: 10, x: 0, y: 5)
                            .opacity(viewModel.inputAmount.isEmpty ? 0.5 : 1)
                    }
                    .padding(.horizontal)
                    .disabled(viewModel.inputAmount.isEmpty)

                    if !viewModel.convertedAmount.isEmpty {
                        Text("Converted Amount: \(viewModel.convertedAmount)")
                            .font(.headline)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).opacity(0.8))
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            .padding(.top)
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).opacity(0.9))
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .navigationTitle("Currency Converter")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Currency Converter")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .shadow(color: .gray.opacity(0.4), radius: 3, x: 0, y: 2)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                    }
                }
                .onAppear {
                    viewModel.fetchExchangeRates()
                }
                .padding()
            }
        }
    }
}
