# Flutter News App

**Overview**

The News Search App is a Flutter application that allows users to:
1. Explore the latest news from various sources.
2. Search for news articles on specific topics.
3. View detailed news articles with smooth navigation.
4. Utilize recent searches for quick access.

This app is designed with clean architecture and follows the separation of concerns principle using Bloc for state management.


**Features**

1) Latest News: Displays a list of the most recent news articles.
2) Search Functionality: Allows users to search for news on specific topics.
3) Recent Searches: Suggests recent searches when typing in the search bar.
4) Pagination Support: Loads more articles dynamically as the user scrolls.
5) Hero Animation: Provides a smooth transition between the news list and detail screen.


## Getting Started

**Setup Instructions**

1. Clone the Repository
   Run the following command to clone and open the project:-
   1) git clone https://github.com/MSNegi123/flutter_news_app.git
   2) cd news-search-app
2. Install Dependencies
   `Run the following command to install the required packages:-`
   `flutter pub get`
3. Download .env file from the attachments and place it at the root location of the flutter project
   `Replace API-KEY in the .env file with your <API-KEY> if required or expired.`
4. Run the Application
   `To run the app on an emulator or a connected device, use:-`
   `flutter run`


**Why Bloc for State Management?**

This app follows clean architecture, and Bloc was chosen for:
1. Separation of Concerns: UI, business logic, and data handling are clearly separated.
2. Scalability: Bloc ensures a structured and scalable approach to state management.
3. Maintainability: Code is easier to test, debug, and extend.


**Screenshots**

![news_list_page.png](screenshots%2Fnews_list_page.png)
![news_detail_page.png](screenshots%2Fnews_detail_page.png)
![recent_search.png](screenshots%2Frecent_search.png)
![matching_search.png](screenshots%2Fmatching_search.png)

Enjoy exploring the latest news with the News Search App! 🚀