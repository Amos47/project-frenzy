# Project Frenzy

This app is mainly about learning how the cucumber test environment works, and exploring testing more in general.

The basic functionality is that professors can sign up and create projects,
and students can sign up and be attributed on projects.

Can be found on github here: https://github.com/Amos47/project-frenzy

## Some implementation choices
  - I decided to put the content of the user login at the top right as it's more common. Can't imagine that is a problem.
  - I decided to use rails and the ruby cucumber stack, it tends to work well, and I was told the language wasn't important.
  - I decided to do actual email/password sign up and login, so the professor does not have to sign up a student.
    This was just something I wanted to practice.
  - I decided to show a 404 `RoutingError` on validating routes, this will however show as error screens in the
    dev environment this runs in.
  - I had some fun with names and descriptions using the faker library instead of the static names.

## Setup:

### Ruby version
  - Currently using ruby 2.3.3. There should be no issue with anything > 2.2, but it's not tested.
  - You can update your system ruby using `brew` on mac or `apt-get` on linux.
  - Alternatively you can use `rvm` or `rbenv` to use multiple versions of ruby. I use `rvm` personally

### Rails
  - This is a rails 5.0.0.1 app you will need to install [Ruby on Rails](https://github.com/rails/rails) with `gem install rails`.
  - You may also need [Bundler](http://bundler.io/), you can see if ruby installed it with `which bundler`.
    Otherwise use `gem install bundler` to install.

### System dependencies
  - Not tested on windows. Rails and windows historically don't do well together.

### Download the project
  - Download from the github repo either through a clone or as a zip.
  - You will need to run `bundle install`, you can speed up the process with multiple threads `bundle install --jobs 7`.

### Database creation
  - This uses a sqlite3 database, so there should be no need for an external database service to be running
  - To create the database run `rake db:migrate`

### Database initialization
  - For testing you may need to run `rake db:test:prepare`, though `rake db:migrate` should do this for you.
  - The testing database is created using fixtures defined in `test/fixtures`.
  - There is also development database seeds, run `rake db:seed` to seed the database with the values outlined.

## Running the server
  `rails server` or `rails s`.

  - Should be bound to port 3000, but just read the console output.
  - You can sign in with `s1@test.com`, `s2@test.com` ... `s10@test.com` with the password `password`
  - And you will also have professor with `p1@test.com` with the always secure password `password`

## Testing
There are really two sets of test suites:

- The the larger rails controller tests that I used to TDD the app. Run with `rake test`.
  - The files are mostly in `test/controllers`
- There is also the cucumber test suite. Run with `bundle exec cucumber`.
  - You can find the files in `features` and `features/step_definitions`
- You can run all the tests in both suites with the command `rake`.
