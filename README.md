##Store##

Is a Rails application that provides a store front for any kind of business

* Database configuration

Copy and enter the information for the database: 

```
cp /config/database.yml.template /config/database.yml
```

* Secret keys

if you are going to deploy to Heroku, create the enviromental variable:

```
heroku config:set SECRET_KEY_BASE='a5d162.....uytuyt65fgh'
```

* Store information

Update the information in the file `/config/config.yml`

