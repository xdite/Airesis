require 'resque'
require 'resque_scheduler'
require 'resque_scheduler/server'
require 'resque/failure/notifier2'
require 'resque/failure/multiple'
require 'resque/failure/redis'
Resque.redis = Redis.new(:host => '127.0.0.1', :port => '6379')
Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../resque_schedule.yml'))


Resque::Failure::Multiple.configure do |config|
  config.classes = [Resque::Failure::Redis, Resque::Failure::Notifier2]
end

Resque::Failure::Notifier2.configure do |config|
  config.smtp = {:address => Setting.email.address , :port => 587, :user => Setting.email.username ,:secret => Setting.email.password }
  config.sender =  Setting.error.sender
  config.recipients = [Setting.error.receiver]
end