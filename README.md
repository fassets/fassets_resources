# FassetsCore

This project rocks and uses MIT-LICENSE.

# Install

To use this plugin in your rails project, you need to add the gem to your applications `Gemfile`:

{{{
#this needs to be in here for file assets to work. somehow it’s not enough to have it as dependency of fassets_core :/
gem 'paperclip'

# for now the git version of fassets core should be used, since it’s under heavy development
gem 'fassets_core', :git => "git://github.com/fassets/fassets_core.git"
}}}

After that, run the `bundle` command to install all new dependencies.

Then you need to install and run the migrations:

{{{
bundle exec rake fassets_core_engine:install:migrations
bundle exec rake db:migrate
}}}

