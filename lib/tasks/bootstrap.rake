namespace :bootstrap do
  desc "Create Administrator Accounts."
  task :accounts => :environment do
      User.delete_all
      User.create(:email => "admin@domain.com", :password => "12345", :password_confirmation => "12345", :firstname => "AdBase", :lastname => "Admin", :phone => "", :state_id => 1, :is_admin => true)
  end

  desc "Add States."
  task :states => :environment do
    State.delete_all
    # Users
    State.create(:category_id => 100, :title => "Active")
    State.create(:category_id => 100, :title => "Passive")

    # Sites
    State.create(:category_id => 200, :title => "Active")
    State.create(:category_id => 200, :title => "Passive")

    # Zones
    State.create(:category_id => 300, :title => "Active")
    State.create(:category_id => 300, :title => "Passive")

    # Ads
    State.create(:category_id => 400, :title => "Published")
    State.create(:category_id => 400, :title => "Expired")
    State.create(:category_id => 400, :title => "Active")
    State.create(:category_id => 400, :title => "Archive")
  end

  desc "Run all bootstrapping tasks."
  task :all => [:accounts, :states]
end