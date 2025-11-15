# ticket_mobile_test

A simple ticket management app built with **Flutter**, **Provider**, and **SQLite**.

## Features
- View ticket list
- Filter by status (ALL, OPEN, IN_PROGRESS, DONE)
- Add ticket (title, description, category)
- Ticket detail page
- Update ticket status
- Status default: OPEN

## Tech
- Flutter
- Provider (state management)
- SQLite (local database)

## Run
flutter pub get
flutter run

shell
Copy code

## Structure
lib/
├─ db/database_helper.dart
├─ models/ticket.dart
├─ provider/ticket_provider.dart
├─ screens/
│ ├─ ticket_list_screen.dart
│ ├─ ticket_add_screen.dart
│ └─ ticket_detail_screen.dart
└─ main.dart

markdown
Copy code

## Database
Table: **tickets**
- id  
- title  
- description  
- category  
- status  
- createdAt  
