# FassetsResources

This project rocks and uses MIT-LICENSE.

# Install

To use this plugin in your rails project, you need to add the gem to your applications `Gemfile`:

```
#this needs to be in here for file assets to work. somehow it’s not enough to have it as dependency of fassets_resources :/
gem 'paperclip'
gem 'fancybox-rails'

# for now the git version of fassets core should be used, since it’s under heavy development
gem 'fassets_resources', :git => "git://github.com/fassets/fassets_resources.git"
```

After that, run the `bundle` command to install all new dependencies.

Then you need to install and run the migrations:

```
bundle exec rake fassets_resources_engine:install:migrations
bundle exec rake db:migrate
```

