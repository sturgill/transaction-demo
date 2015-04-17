namespace :model_driven do
  desc 'Create a new ModelDriven::User'
  task user: :environment do
    perform ModelDriven::User
  end

  namespace :transaction do
    task user: :environment do
      transaction_perform ModelDriven::User
    end
  end
end

namespace :database_driven do
  desc 'Create a new DatabaseDriven::User'
  task user: :environment do
    perform DatabaseDriven::User
  end

  namespace :transaction do
    desc 'Create a new DatabaseDriven::User within a locking transaction'
    task user: :environment do
      transaction_perform DatabaseDriven::User
    end
  end

  task read: :environment do
    p DatabaseDriven::User.where(username: ENV['USERNAME'])
  end
end

def perform(klass)
  raise 'you need a USERNAME' if ENV['USERNAME'].blank?

  user = klass.new(username: ENV['USERNAME'])
  user.delay_me unless ENV['DELAY'].blank?
  sleep(20)
  user.save

  user_count = klass.where(username: ENV['USERNAME']).count
  puts "#{klass.name} users with username '#{ENV['USERNAME']}': #{user_count}"
end

def transaction_perform(klass)
  raise 'you need a USERNAME' if ENV['USERNAME'].blank?
  TransactionLock.perform("class: #{klass.name} | username: #{ENV['USERNAME']}") do
    perform klass
  end
end
