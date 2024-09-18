# MarshallAssignment
# Crypto App

This project is a Swift-based application that fetches cryptocurrency data and exchange rates, and allows users to convert prices between different currencies(USD and SEK). The app uses Combine for reactive programming tofetch exchange rates also Async await to fetch the Crypto List and includes unit tests for some cases.

## Table of Contents

- [Project Description](#project-description)
- [Features](#features)
- [Requirements](#requirements)
- [Usage](#usage)
- [Testing](#testing)

## Project Description

The Crypto  App fetches cryptocurrency data and exchange rates from various APIs. It allows users to view cryptocurrency prices in different currencies and convert prices between INR, USD, and SEK. The app is built using Swift and Combine, and includes unit tests tried to explore the new swift testing framework.

## Features

- Fetch cryptocurrency data from the WazirX API.
- Fetch exchange rates from the XE API. https://xecdapi.xe.com/v1/central_bank_rate?central_bank=SWE&to=USD&amount=1&inverse=false&decimal_places=20&margin=0&fields=mid
- Convert prices between base(INR), USD, and SEK.
- Toggle between USD and SEK for price display.
- Unit tests for some key functionalities.

## Requirements

- Xcode 16.0 or later
- iOS 18.0 or later

## Usage

1. Launch the app on your iOS device or simulator.
2. The app will fetch cryptocurrency data and exchange rates.
3. View cryptocurrency prices in USD, or SEK.
4. Toggle between USD and SEK for price display.

## Testing

The project includes unit tests. The tests are written using the new Swift Testing framework.

### Test Cases

The following test cases are included:

- **Toggle Currency**: Tests the toggling of the currency between USD and SEK.
- **Fetch Crypto List Success**: Tests the successful fetching of crypto data.
- **Fetch Crypto List Failure**: Tests the failure scenario when fetching crypto data.
- **Fetch Exchange Rates**: Tests the fetching of exchange rates from INR to USD and USD to SEK.
- **Convert Price to USD**: Tests the conversion of a price from INR to USD.
- **Convert Price to SEK**: Tests the conversion of a price from INR to SEK.
