desc "This task is called every 10 mins to create a new batch of the most recently approved, least shown messages"
task :create_new_batch => :environment do
  Tenant.all.each { |tenant| tenant.create_batch }
end