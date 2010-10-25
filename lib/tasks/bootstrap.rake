namespace :bootstrap do
  desc "Create Administrator Accounts."
    task :accounts => :environment do
      User.delete_all
      User.create(:email => "admin@", :password => "bardak", :password_confirmation => "bardak", :firstname => "Soner", :lastname => "Eker", :phone => "05079967952", :state_id => 27)
  end

  desc "Add States."
  task :states => :environment do
    State.delete_all
    # Users
    State.create(:category_id => 100, :title => "Aktif")
    State.create(:category_id => 100, :title => "Pasif")

    # Sites
    State.create(:category_id => 200, :title => "Aktif")
    State.create(:category_id => 200, :title => "Pasif")

    # Zones
    State.create(:category_id => 300, :title => "Aktif")
    State.create(:category_id => 300, :title => "Pasif")

    # Ads
    State.create(:category_id => 400, :title => "Yayında")
    State.create(:category_id => 400, :title => "Süresi Doldu")
    State.create(:category_id => 400, :title => "Beklemede")
    State.create(:category_id => 400, :title => "Arşivde")
  end

  desc "Run all bootstrapping tasks."
  task :all => [:states]
end