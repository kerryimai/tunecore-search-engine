# TuneCore Search Engine
A Ruby on Rails search platform for music by any combination of artists, albums and songs.


## Create database and seeding:

After cloning the repo, move in to the folder and run each individually:

```
bundle install
rails db:create
rails db:migrate
rails db:seed
```

- Nokogiri is implemented in the seed file to scrape data from wikipedia links
- "Scraping success" will be logged in console when Nokogiri seeding completes.
- if have issue implementing Nokogiri due to local configs, local seed data is also available for use.

## Start server
run command:
```
rails s
```
Then navigate to `localhost:3000`

## Running the tests:
To run the tests, simply run:
```
rspec
```

## Technology Used:

* Ruby on Rails - frontend & backend
* Nokogiri - web scraping
* Postgres - database
* Jquery - frontend
* Ajax - frontend
* Bootstrap - for styling
* Sass - for Styling
* Rspec - testing
* Factory girl - test data mocking
