# Cancannible Demo with Rails 4.2
[![Build Status](https://travis-ci.org/evendis/cancannible_demo4.svg?branch=master)](https://travis-ci.org/evendis/cancannible_demo4)

A Rails 4.2.x application that demonstrates how to use [Cancannible gem](https://github.com/evendis/cancannible) for role-based access permissions.

This can be used interactively at [cancannibledemo4.evendis.com](http://cancannibledemo4.evendis.com/).

See [cancannibledemo.evendis.com](http://cancannibledemo.evendis.com/) for the Rails 3.x version of the demo,
with source also on [GitHub](https://github.com/evendis/cancannible_demo).

## How to run the application locally

    # clone the app and bundle (NB: assumes you have a working ruby 2 environment)
    git clone https://github.com/evendis/cancannible_demo4.git
    cd cancannible_demo4
    bundle install

    # create and verify a db user (the app uses PostgreSQL by defualt)
    psql postgres -c "create role cancannible_demo4 with login superuser"
    psql postgres -U cancannible_demo4 -c "\c"

    # setup the database
    rake db:setup

    # now you are ready to go..
    rails s
    open http://localhost:3000

## Tests

Tests are written with the Rails standard framework, Minitest, and are found in the [./test](./test) folder.
See the Rails 3 version of the demo for an example of testing with [RSpec](https://www.relishapp.com/rspec/rspec-rails/docs).

Only tests that specifically demonstrate cancannible-related behaviour are included, to avoid confusing the issue.

## Implementation Notes

The application uses [haml](http://haml.info/) for convenience and clarity. There's no dependency however; all this works fine with ERB or other view styles. The [customers_controller.rb](./app/controllers/customers_controller.rb) provides an example of standard ERB views.
