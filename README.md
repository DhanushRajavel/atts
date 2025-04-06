---

# ATTS Jewelry App (JWYY)

A Flutter-based mobile application for managing jewelry products, billing, and history with user authentication.

## Overview

The **ATTS Jewelry App** is designed to streamline product management and billing processes for a jewelry business. It features a clean UI, local storage for billing history, and a simple authentication system. Built with Flutter and the `provider` package for state management, this app demonstrates a modular architecture suitable for small-scale business applications.

## Features

- **User Authentication**: Login/logout functionality with mock credentials (`test@atts.com` / `123456`).
- **Product Management**: Add, edit, and delete jewelry products with details like name, price, category, discount, and tax.
- **Billing System**: Generate bills with quantity adjustments, discounts, taxes, and PDF export.
- **Billing History**: View past billing records with search, filter, sorting, pagination, and lazy loading.
- **Responsive UI**: Grid-based product display and intuitive navigation.

## Prerequisites

- **Flutter SDK**: Version 3.x.x or higher
- **Dart**: Version 2.18.x or higher
- **IDE**: Android Studio, VS Code, or any Flutter-compatible editor
- **Dependencies**: Listed in `pubspec.yaml`

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/jwy.git
   cd jwy
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the App**:
   - Connect a device/emulator.
   - Run the app:
     ```bash
     flutter run
     ```

4. **Build APK (Optional)**:
   ```bash
   flutter build apk --release
   ```

## Usage

1. **Login**:
   - Use credentials: `test@atts.com` / `123456`.
   - Successful login navigates to the product management screen.

2. **Manage Products**:
   - Click the FAB (`+`) to add a new product.
   - Tap a product card to bill it, or use edit/delete options.

3. **Billing**:
   - Adjust quantity and click "Total" to save the bill and generate a PDF.

4. **View History**:
   - Access via the history icon in the app bar.
   - Search, sort, and scroll to load more records.

5. **Logout**:
   - Click the logout icon in the app bar to return to the login screen.

## Project Structure

```
jwy/
├── lib/
│   ├── model/              # Data models (Product, BillingRecord)
│   ├── services/           # Business logic (AuthService, BillingHistoryServices)
│   ├── utils/              # Constants and utilities
│   ├── view/               # UI screens (LoginView, ProductView, etc.)
│   ├── viewmodel/          # State management (LoginViewModel, ProductViewModel, etc.)
│   ├── widgets/            # Reusable UI components (ProductCard, AddProductDialog)
│   └── main.dart           # App entry point
├── pubspec.yaml            # Dependencies and configuration
└── README.md               # This file
```

## Dependencies

- `provider`: State management
- `shared_preferences`: Local storage for billing history
- `pdf`: PDF generation
- `printing`: PDF printing
- `google_fonts`: Typography

See `pubspec.yaml` for full details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or feedback, reach out via [dhanushrajavel24@gmail.com](mailto:dhanushrajavel24@gmail.com) or open an issue on GitHub.

---

### Customization Tips
- **License File**: If you don’t have a `LICENSE` file, create one with the MIT License text or your preferred license.
- **Known Issues**: Update this section based on any current bugs you’re aware of.
