# Grammable - An Instagram Clone Application
This application is a deep dive into Test Driven Development. Utilizing Ruby gem RSpec to build automated software tests, the Grammable App ensures good test coverage and releases perfectly tested code on the level of a professional developer. HTML, CSS, Ruby, Rails, Algorithms.

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Status](#status)
* [Sources](#sources)
* [Contact](#contact)

## General info
An application very similar to Instagram where users are able to load and view post listings featuring images, comments, user email, edit, destroy, new post form, user log-in/log-out and registration pages. This application focuses primarily on using Test Driven Development with the Ruby gem RSpec. 


## Technologies 
Project is created with:

*[ruby gem RSpec](https://github.com/rspec/rspec-rails)
* [ruby '2.5.3'](https://github.com/university-bootcamp/coding-environment/blob/master/README.md#coding-environment-installation-guide)
* gem 'rails', '~> 5.2.3'
* [Heroku](https://signup.heroku.com/t/platform?c=70130000001xDpdAAE&gclid=CjwKCAiAzuPuBRAIEiwAkkmOSM8vVAtL7RKLqoIVrshH7VuxMysxD2e1555A3dwyDU4sOSOxy6zujxoCXBIQAvD_BwE)
* [HTML5](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/HTML5)
* [CSS](https://www.w3schools.com/html/html_css.asp)
* [gem 'devise'](https://github.com/plataformatec/devise)
* [AWS](https://aws.amazon.com/)
* [Bootstrap](https://github.com/twbs/bootstrap-rubygem)
* [gem simpleform](https://github.com/plataformatec/simple_form)
* [Devise gem](https://github.com/plataformatec/devise)
* [FactoryBot gem](https://github.com/thoughtbot/factory_Bot/blob/master/GETTING_STARTED.md)
* [Carrierwave](https://github.com/carrierwaveuploader/carrierwave)
## Setup   
Set up a development environment and start a new project

**Getting Started**

Go to one of the terminals within your coding environment and type the following:
  ```
  $ cd /vagrant/src
  ```
Create a new application that uses postgres
  ```
  $ rails new grammable --database=postgresql
  ```
Open newly created grammable application in your text editor and go to database.yml file and edit:
  ```
  username: postgres
  password: password
  host: localhost
  ```
comment out last two lines on file for username and password.

Change directory into your Grammable project
  ```
  $ cd /vagrant/src/grammable
  ```
Create your initial database
  ```
  $ rake db:create
  ```
Start the server:
  ```
  $ rails server -b 0.0.0.0 -p 3000
  ```
In the second terminal window, type following command to move into Grammable folder:
  ```
  $ cd /vagrant/src/grammable
  ```
Set up web development pipeline:
  
    create new Github repository

    create project in heroku and then deploy it to heroku

## Set Up the Testing Environment

Follow [Ruby gem RSpec documentation](https://github.com/rspec/rspec-rails) and make the following adjustments:

Open Gemfile and add these lines to the bottom:
  ```
  group :development, :test do
    gem 'rspec-rails', '~> 3.5'
  end
  ```

  Go into terminal and run
  ```
  $ bundle install
  ```

  Ruby on Rails will output text indicating that it created a folder and several files within it.

  Delete the default test folder from your Ruby on Rails application since we are using rspec.
  ```
  $ rm -rf test
  ```
  then run
  ```
  $ bundle exec rspec
  ```
  We should now have 0 passing and 0 failing tests shown in the terminal window.

**Create a Test**

The root page will list all our posts. So let's generate a controller "grams" to put inside the index action:
```
$ rails generate controller grams
```
We run our tests by running the following command: bundle exec rspec. Running this command will replace us firing up a web browser and pressing refresh to see if things are working.

Since we haven't written any code yet, our test should pass. Let's make sure that's still true.

Run the test suite again by running the following command:
```
$ bundle exec rspec
```
It tells us we have one test that is pending. It outputs the following to the terminal:
```
Pending: (Failures listed here are expected and do not affect your suite's status)

1) GramsHelper add some examples to (or delete) /vagrant/src/grammable/spec/helpers/grams_helper_spec.rb
# Not yet implemented
# ./spec/helpers/grams_helper_spec.rb:14
```
It tells us we have one pending test. That's because when we generated our grams controller, it gave us one placeholder test to give us a place to look. Edit spec/helpers/grams_helper_spec.rb and remove the line so it looks like this:
```
RSpec.describe GramsHelper, type: :helper do

end
```
Save the file and run the test suite again:
```
$ bundle exec rspec
```
The response returns to tell us we don't have any tests failing or passing. That is because we have not written any tests yet.

**Write the First Test**

We want to test that when someone visits our site and performs a GET HTTP request to a URL that looks like /, they should receive a successful HTTP response from our application.

The next step of the process is to convert the above specification into code. Since the root page will be located in the grams_controller.rb, the specification of this will be in grams_controller_spec.rb.

Open spec/controllers/grams_controller_spec.rb and add the following code to the file.
```
require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do

  end
end
```
If we read the code as plain English, it explains what it's doing. This is setting up a section (between the do and the end) that will "describe" how the grams#index action behaves. 

Add the following to spec/controllers/grams_controller_spec.rb:
```
RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do

    end
  end
end
```
The following code in spec/controllers/grams_controller_spec.rb will trigger an HTTP GET request to the index action of our controller:

```
RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
    end
  end
end
```
Next, let's verify that the page loads successfully. To do so, add line   expect(response).to have_http_status(:success) after get :index:
```
RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
```
The line we added tells our tests that we expect the response to have an HTTP status code that's successful. That's very close to what our plain English specification was.

Let's save the file and run our test suite again.
```
$ bundle exec rspec
```
This produces an error message telling us our test failed. This is because we haven't implemented our code yet. We're currently working in a flow that is known as a Red/Green/Refactor cycle. That means we'll perform the following actions in this order.

* Add the specification.
* See that our application doesn't conform to the specification we've just outlined.
* Fix our application so it does conform to the specification.
* Then improve the quality of our application's code.
The error message we see for this specific failing spec looks like this:
```
1) GramsController grams#index action should successfully show the page
Failure/Error: get :index
ActionController::UrlGenerationError:
 No route matches {:action=>"index", :controller=>"grams"}
# ./spec/controllers/grams_controller_spec.rb:6:in `block (3 levels) in '
```
This suggests that the problem is on grams_controller_spec.rb on line 6, and that our problem is that No route matches. The first step with a failing test is usually finding the line of code it's failing on. In this case, it's failing here at the get:index:
```
RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
```
Our test is failing at the point when we trigger the HTTP GET request to the index action. Our application indicates the error message is: No route matches.

Run the command to output the routing table:
```
$ rake routes
```
In order for the test to pass, we'd need to see a root URL hooked up in the output, but it isn't there. Because we haven't hooked up the routes file, our specification is failing.

Edit config/routes.rb and add the following line.
```
Rails.application.routes.draw do
  root "grams#index"
end
```
Save the file. Now run the command to display the routes table.
```
$ rake routes
```
It outputs this:
```
root GET / grams#index
```
That means when in our test we write the code get :index, we'll fire off an HTTP get request to the index action grams#index, which is now hooked up through the routes.

Let's run our tests again.
```
$ bundle exec rspec
```
Our test fails again. Now it gives us this failure message:
```
1) GramsController grams#index action should successfully show the page
Failure/Error: get :index
AbstractController::ActionNotFound:
 The action 'index' could not be found for GramsController
# ./spec/controllers/grams_controller_spec.rb:6:in `block (3 levels) in '
```
The error message The action 'index' could not be found for GramsController is similar to error messages we've seen before. It happens when we haven't hooked up the action in the controller yet.

To fix this, add the following two lines to the app/controllers/grams_controller.rb file.
```
class GramsController < ApplicationController
  def index
  end
end
```
Save the file. Let's try again:
```
$ bundle exec rspec
```
Our test fails again! This time, the test output is the following:
```
 1) GramsController grams#index action should successfully show the page
     Failure/Error: get :index
     ActionView::MissingTemplate:
       Missing template grams/index, application/index with {:locale=>[:en], :formats=>[:html], :handlers=>[:erb, :builder, :raw, :ruby, :jbuilder, :coffee]}. Searched in:
         * "#"
     # ./spec/controllers/grams_controller_spec.rb:6:in `block (3 levels) in '
```
This time, the error message indicates: Missing template grams/index. Again, we've seen similar error messages to this in the past as well. This happens generally when we haven't added a view to our action in our application yet.

Add a view to the grams controller index action. Create app/views/grams/index.html.erb and add the following:
```
<h1>Grams!</h1>
```
Save the file. Let's give our tests a spin again.
```
$ bundle exec rspec
```
This time we don't see error messages! Instead we see output that looks like this.
```
.

Finished in 0.14667 seconds (files took 5.16 seconds to load)
1 example, 0 failures
```
The single period indicates we've run one test. The bottom indicates that we've had 1 example and 0 failures.

Success! Our application now has a root page and it's working. And on top of that, we can know that it's working without even viewing the page!

**Install Bootstrap**
Follow [Boostrap documentation](https://github.com/twbs/bootstrap-rubygem) to install Bootstrap and get our application looking awesome.

**Install SimpleForm gem**
Follow [SimpleForm documentation](https://github.com/plataformatec/simple_form) to install SimpleForm gem so we can easily add forms to our application.

**Install Devise gem**
Follow [Devise gem documentation](https://github.com/plataformatec/devise) to install devise gem in order to provide user authentication.

**Install FactoryBot gem**
Follow [FactoryBot gem documentation](https://github.com/thoughtbot/factory_Bot/blob/master/GETTING_STARTED.md) to install FactoryBot which we will use to add dummy data to our app to test.


## Status
Project is fully-functioning, user-friendly and complete. You can find it deployed on heroku via: [Flixter Application](https://flixter-raquele-crotti.herokuapp.com/)


## Sources
This app was created during my time completing UC Berkeley Extension's  Coding Bootcamp Program.

## Contact 
* [Portfolio](https://www.raquelecrotti.com/)
* [LinkedIn](https://www.linkedin.com/in/raquele-crotti/)
* [Github](https://github.com/Raquele-Crotti)
