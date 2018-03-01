# 1.  Setup Project

## Prerequisites 
- Postgresql db

## Steps
- Clone the project and change to its directory

```shell
git clone git@github.com:rafaelmacielrsm/iw-app.git
```
```shell
cd iw-app
```

- Rename both database and secrets yaml config files

```shell
mv config/database.yml.example config/database.yml
```
```shell
mv config/secrets.yml.example config/secrets.yml
```

- Setup your database user and password, using your favoride editor, in the example i'm using visual code

```shell
code config/database.yml
```
edit those lines:

```yaml
development:
  <<: *default
    username: <database_username>
    password: <database_password>
    database: iw-app_development
  
  # and
  
  test:
  <<: *default
    username: <database_username>
    password: <database_password>
    database: iw-app_test
```

- Install dependencies

```shell
bundle install
```

- Create Databases and run migrations

```shell
rake db:create && rake db:migrate RAILS_ENV=development && rake db:migrate RAILS_ENV=test 
```

- Run tests or launch the app

```shell
rspec -f d
# or depending on your rails setup
bundle exec rspec -f d
#run server and visit http://localhost:3000
rails s
```



