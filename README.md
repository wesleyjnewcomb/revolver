[ ![Codeship Status for wesleyjnewcomb/revolver](https://app.codeship.com/projects/98990e50-4d42-0135-671f-7ac7c1b513e1/status?branch=master)](https://app.codeship.com/projects/233141)
![Code Climate](https://codeclimate.com/github/wesleyjnewcomb/revolver.png)
![Coverage Status](https://coveralls.io/repos/wesleyjnewcomb/revolver/badge.png)

# README

Revolver is a web application for sharing album reviews. Utilizing ‘Test Driven Development,’ it was built with ReactJS on top of Rails and a PostgreSQL database. Revolver features a dynamically rendered interface for users to interact with. Users can create secure accounts (Devise) and upload an avatar to be associated with their profile, then add and review albums, and vote to show approval (or disapproval) of reviews.

Our team created this application as a fun demonstration of our RoR and ReactJS skills, and also as the fulfillment of an assignment.

Revolver has been deployed to Heroku: (address)

## Technologies:

### General:
* Rails - for its neat implementation of MVC structures, and for its wonderful magic
* ReactJS - for a smooth and dynamic UX/UI
* React Router - to handle navigation among React components
* PostgreSQL - for its compatibility with Heroku

### Testing:
* Rspec - for testing Ruby code
* Capybara - to allow feature-testing driven by use-cases and user-stories
* Jasmine/Enzyme - to test the output of ReactJS components

### Libraries of note:
* Devise - to handle user-account creation and management
* CarrierWave - to allow avatar images for profiles (stored on AWS)

## To run this application locally:

Clone from command line:
```
$ git clone https://github.com/wesleyjnewcomb/revolver.git
```
Navigate into directory:
```
$ cd ./revolver
```
Install required Ruby gems and Node modules:
```
$ bundle && npm install
```
Initialize database:
```
$ rake db:create && rake db:migrate
```
Initialize local server:
```
$ rails s
```
To get ReactJS frontend running:
```
$ npm start
```
To play with the app, open a browser window and in the URL bar enter
`localhost:3000 `

Enjoy!

## To run the tests:

Rspec and Capybara tests:
```
$ rake
```
Jasmine/Enzyme
```
$ npm test
```

After running npm test, open a new browser tab/window and in the URL bar enter
`localhost:9876`
Return to terminal window to view test results


## Credits:

Revolver was created by Zerell Gardner (Hazumon), (nm357), Wesley Newcomb (wesleyjnewcomb), and Dan Simon (daniel-simon).

Special thanks to our classmates and instructors at Launch Academy, Boston.
