
# Ecommerce App

## Architecture

This project follows the principles of TDD (Test-Driven Development) and Clean Architecture. The architecture is divided into three main layers:

1. **Presentation Layer**: This layer is responsible for the UI and user interaction. It contains the widgets, screens, and state management logic.
2. **Domain Layer**: This layer contains the business logic of the application. It includes entities, use cases, and repositories. The domain layer is independent of any other layers.
3. **Data Layer**: This layer is responsible for data management. It includes models, data sources, and repositories. The data layer interacts with external data sources such as APIs, databases, and local storage.

## Data Flow

The data flow in the application follows a unidirectional pattern:

1. **User Interaction**: The user interacts with the UI in the presentation layer.
2. **Presentation Layer**: The presentation layer sends requests to the domain layer through use cases.
3. **Domain Layer**: The domain layer processes the requests and interacts with the data layer through repositories.
4. **Data Layer**: The data layer fetches or stores data from/to external sources and returns the data to the domain layer.
5. **Domain Layer**: The domain layer processes the data and returns the results to the presentation layer.
6. **Presentation Layer**: The presentation layer updates the UI based on the results from the domain layer.

## Current Implementation

### Domain Layer

The domain layer has been fully implemented. It includes the following components:

- **Entities**: Core business objects.
- **Use Cases**: Business logic for specific actions.
- **Repositories**: Interfaces for data access.

### Data Layer

The data layer is being implemented, including the models and their corresponding tests. The data layer components include:

- **Models**: Data representations used throughout the application.
- **Data Sources**: Interfaces and implementations for data fetching and storage.
- **Repositories**: Concrete implementations of the domain layer repositories.

### Testing

Following TDD principles, tests have been written for the domain and data layers to ensure the correctness and reliability of the application.

