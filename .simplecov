require 'simplecov'
require 'coveralls'
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
   add_filter 'app/channels'
   add_filter 'app/jobs'
   add_filter 'app/mailers'
   add_filter 'app/models/user.rb'
end