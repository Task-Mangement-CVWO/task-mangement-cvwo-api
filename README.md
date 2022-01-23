# Task Manager (API)

## Documentation and Deployment

- [Postman Documentation](https://documenter.getpostman.com/view/11771909/UVXqDsTi)
- [https://tm-cvwo-api.herokuapp.com/](https://tm-cvwo-api.herokuapp.com/)

## Getting Started

1. Install `rvm` on your machine
2. Run `rvm install ruby-3.0.3`
3. Run `rvm use`
4. Run `gem install rails`
5. Run `bundle install` in the working directory to install required packages
6. Copy `.env.example` and create your own enviroment variables
7. Setup database
    - `rake db:create`
    - `rake db:migrate`
    - `rake db:seed`
8. Run `rails s` to run the app on localhost
