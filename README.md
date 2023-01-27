# APMS Mobile Application

A mobile car booking and check-in/out of parking lot application, written using the Flutter framework (Dart language).

## Table of Contents
- [Getting Started](#getting-started)
- [Main Features](#main-features)
- [Screenshots](#screenshots)
- [Setup](#setup)
- [Technologies](#technologies)
- [Team Members](#team-members)
- [Acknowledgements](#acknowledgements)

## Getting Started
Automatic Parking Management and Parking Fee Collection System (APMS) is a project aimed to deliver a contactless solution by automating the process of managing public car parking lots. By using a combination of car detection, license plate recognition (LPR), and a mobile application, the process of checking in/out of a car park can be done without the needs for other tools such as RFID cards or hand-written tickets, thus create a less time-consuming and more secured parking experience for customers.

This mobile application is a part of the project, provided for the customers using the APMS system. 

## Main Features
- Book a parking slot in advanced
- Scan QR to perform check-in/out process
- Track past, current and upcoming parking tickets
- Search and display nearby parking lots, with an approximate distance calculated using GPS
- Personal wallet top-up using Paypal

## Screenshots
<p align="center">
  <img src="https://user-images.githubusercontent.com/77088395/215063737-ab8aba75-d486-47e7-bbb5-35104a7c5bd6.png" />
</p>
![Home Screen](https://user-images.githubusercontent.com/77088395/215063737-ab8aba75-d486-47e7-bbb5-35104a7c5bd6.png)
![Booking Screen](https://user-images.githubusercontent.com/77088395/215063611-0c4cf5a2-7c82-40b2-8a17-f709fb748bf0.png)
![Booking Confirmation Screen](https://user-images.githubusercontent.com/77088395/215063620-cbcde59e-a43a-43c0-990f-5a09be9635fb.png)
![Ticket List Screen](https://user-images.githubusercontent.com/77088395/215063630-c0e3a0eb-a134-48ec-a8b3-075e057777a2.png)
![Ticket Detail Screen](https://user-images.githubusercontent.com/77088395/215063641-b00117f7-1a04-4878-9131-549a5e0bd996.png)
![Profile Screen](https://user-images.githubusercontent.com/77088395/215063655-19faf009-6ada-4ec8-ab57-93cc43e22266.png)
![Transaction History Screen](https://user-images.githubusercontent.com/77088395/215063650-38c6e02b-aced-4df1-bd50-1cf9dd04dae3.png)

## Setup
**Disclaimer: The backend platform has been disabled, due to insufficient funds for the hosting cost. Thus, this application might not work properly.**
- Clone this repository
- Cd to the project path
```
    $ cd <your_path>/apms_mobile
```
- Install the required libraries
```
    $ flutter pub get
```
- Build apk
```
    $ flutter build apk --release
```
- Install the apk using an emulator or your own device (Android preferably)

## Technologies
- Flutter (Dart) - mobile frontend
- .NET 6 (C#) - backend
- Firebase - storing images
- AWS (EC2) - hosting backend
- Bitbucket - storing codebase
- ...

## Team Members
- [Khuc Ngoc Thai](https://github.com/Benjamin271201) - Leader, mobile & devops
- [Tang Chi Cuong](https://github.com/chicuong223) - Backend
- [Thuy Vo Anh Hoang](https://github.com/HoangTVA) - Embedded system
- [Ho Huu Phat](https://github.com/idark2004) - Mobile & image processing 
- [Nguyen Quang Dung](https://github.com/Wolf1910) - Frontend

## Acknowledgements
Our deepest appreciation to our mentors, Mr. Kiều Trọng Khánh & Mr. Đặng Ngọc Minh Đức, for putting so much time and effort into this project. Your suggestions and advices are invaluable.





