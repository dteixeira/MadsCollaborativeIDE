Sinatra Bootstrap
================

Simple skeleton to kick start your modular [Sinatra](http://www.sinatrarb.com/) applications.
Most commonly used features and gems are included and already configured.

This bootstrap was developed and tested using __Ruby 2.0.0__, although it should work well with __Ruby 1.9.3__.
It is recommended that you use [RVM](https://rvm.io/).

## Installation

Just clone this repository, go to repository's root and run:

```
bundle install
```
If you have RVM installed it will automatically create and change your gemset to __sinatra_bootstrap__.
If you don't want this behavior or want a different gemset just open the __Gemfile__ and edit or delete
the following line:

```
#ruby-gemset=sinatra_bootstrap
```

The project contains some _dummy_ files. These are used so that empty folder structure can be tracked
by git. There are some Rake tasks included to deal with suck files:

```
rake create_dummies              # Creates a dummy file in every empty directory
rake remove_dummies              # Deletes any dummies that are no longer needed
rake remove_all_dummies          # Deletes all dummy files in the application
```
If you remove any dummy files that were previously being tracked don't forget to call:

```
git add -u
```

## Getting Started

By default [thin](http://code.macournoyer.com/thin/) will be installed as a web server, although you
can use any server you like. To run the default web server you just need to do:

```
thin start -R 'config.ru'
```

Your application will be accessible through [http://localhost:3000](http://localhost:3000). 

## Configuration

Most configurations are done through __controllers/application_controller.rb__. This file is well
commented and most configurations should self explanatory.
If you want to change which controller answers to what path, you can do that in __config.ru__.

## Included Software

- [Slim](http://slim-lang.com/)
- [Sass](http://sass-lang.com/)
- [Compass](http://compass-style.org/)
- [CoffeeScript](http://coffeescript.org/)
- [DataMapper](http://datamapper.org/)

## Future Updates

- Setup different environments.
- Setup unit tests.
- Build more Rake tasks for common work.

© 2013 Diogo Teixeira. This code is distributed under the MIT license.
