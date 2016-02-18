## Rails 5, JRuby, RedShift Table Browsing Interface

### Description

This project is a Rails 5 JRuby demo project to connect to a Redshift database,
get a list of tables, and show the top 20 records in a table.

### Project Setup
- Add Redshift ENV variable credentials (~/.profile, .env, etc):
  - export REDSHIFT_HOST=
  - export REDSHIFT_PORT=
  - export REDSHIFT_USERNAME=
  - export REDSHIFT_PASSWORD=
  - export REDSHIFT_DATABASE=
- `rvm install jruby-9.0.5.0`
- git clone project
- `bundle install`
- `rake db:create && rake db:migrate`
- `rails s`
- browse to: http://localhost:3000
