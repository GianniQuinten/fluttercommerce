 # fluttercommerce

BADGES
[![Build Status](https://github.com/{owner}/{repo}/actions/workflows/{workflow}.yml/badge.svg)](https://github.com/{owner}/{repo}/actions/workflows/{workflow}.yml)
[![Build Status](https://travis-ci.com/{owner}/{repo}.svg?branch=main)](https://travis-ci.com/{owner}/{repo})
[![codecov](https://codecov.io/gh/{owner}/{repo}/branch/main/graph/badge.svg)](https://codecov.io/gh/{owner}/{repo})
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo={owner}/{repo})](https://dependabot.com)
[![Known Vulnerabilities](https://snyk.io/test/github/{owner}/{repo}/badge.svg)](https://snyk.io/test/github/{owner}/{repo})

---
# Shoe Webshop Flutter Project
## Table of Contents

- [Introduction](#introduction)
- [Installation of the project](#installation-of-the-project)
- [Pubspec YAML](#pubspec-yaml)
- [Connect with the API](#connect-with-the-api)
- [Contact](#contact)

## Introduction
Welcome to the shoe webshop Flutter project made by Gianni van Looij and Quinten Schaap.
This project is designed to provide a seamless shopping experience for shoe enthusiasts,
showcasing a variety of shoe products through a user-friendly mobile application built with Flutter.

## Installation of the project
To get started with the project, follow these steps:

1. **Clone the Repository:**
   First, you need to clone the project repository from GitHub to your local machine.
   Open your terminal and run the following command:

   ```bash
   git clone https://github.com/GianniQuinten/fluttercommerce.git
   ```

2. **Open the Project in Android Studio:**
   After cloning the repository, open Android Studio and select `Open an existing Android Studio project`.
   Navigate to the directory where you cloned the repository and select the project folder.

3. **Install Dependencies:**
   Once the project is loaded in Android Studio, you need to install the required dependencies.
   Open the terminal in Android Studio and run:

   ```bash
   flutter pub get
   ```

4. **Run the Project:**
   Connect your mobile device or start an emulator. Then, run the project using the following command in the terminal:

   ```bash
   flutter run
   ```

## Pubspec YAML
The `pubspec.yaml` file is crucial for managing the project's dependencies and assets. Here’s what it should include:

```yaml
name: fluttercommerce
description: A new Flutter project.

publish_to: 'none' # Remove this line if you want to publish to pub.dev

version: 3.22.1

environment:
  sdk: '>=3.4.1 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  http: ^1.2.1
  web: ^0.5.1
  mockito: ^5.0.0
  provider: ^6.0.4
  prometheus_client: ^1.0.0+1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_driver:
    sdk: flutter
  flutter_lints: ^2.0.1

flutter:
  uses-material-design: true
```

   After doing this make sure you install the dependencies again:
   ```bash
   flutter pub get
   ```

## Connect with the API
To connect the project with the API we have to use MongoDB.
For the installation of MongoDB we used this tutorial: https://www.youtube.com/watch?v=gB6WLkSrtJk

Follow these steps to install MongoDB and connect with the API:
1. **Go to the MongoDB website**
   First, you need to go to the website of MongoDB where you can download the file:

   ```bash
   https://www.mongodb.com/try/download/community
   ```

2. **Install MongoDB**
   After you went to the website, scroll down to the download and make sure you have the following things:

   ```bash
   Version: 7.0.11 (Current)
   Package: msi
   ```

   After that you can press download and the download will start.

3. **Download preferences**
   After you press download you will go and install MongoDB, we recommend you to choose the **Complete setup type**.
   After you chose Complete you just keep everything the same. We also recommend to keep Install MongoDB Compass to be **enabled**
   Now all you have to do finish and it is installed successfully!

4. **Start API in Android Studio**
   Now to start the API in android studio you have to make sure your terminal is in the project.
   If that is the case run the following commands:

   ```bash
   cd backend
   node index.js
   ```

   After you ran these commands the API should startup and then when you run the Project you can see shoes in the webshop.

## Contact
If you encounter any issues or have any questions regarding this project, please contact Quinten Schaap at:

Email: s1190289@windesheim.nl

---


```bash
git clone https://github.com/{owner}/{repo}.git
cd {repo}
npm install
