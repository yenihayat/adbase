# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101104095827) do

  create_table "ads", :force => true do |t|
    t.string   "name",             :limit => 40,                 :null => false
    t.text     "description"
    t.integer  "width"
    t.integer  "height"
    t.string   "target_url",       :limit => 300,                :null => false
    t.boolean  "track_clicks"
    t.boolean  "track_views"
    t.integer  "clicks_count",                    :default => 0
    t.integer  "views_count",                     :default => 0
    t.boolean  "expire"
    t.datetime "expire_at"
    t.integer  "max_clicks_count",                :default => 0
    t.integer  "max_views_count",                 :default => 0
    t.string   "ad_file_name"
    t.string   "ad_content_type"
    t.integer  "ad_file_size"
    t.datetime "ad_updated_at"
    t.integer  "state_id",         :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ads", ["state_id"], :name => "index_ads_on_state_id"

  create_table "site_ads", :force => true do |t|
    t.integer  "ad_id",      :null => false
    t.integer  "site_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_ads", ["ad_id"], :name => "index_site_ads_on_ad_id"
  add_index "site_ads", ["site_id"], :name => "index_site_ads_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "name",       :limit => 300
    t.string   "url",        :limit => 300
    t.integer  "state_id",   :limit => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["state_id"], :name => "index_sites_on_state_id"

  create_table "states", :force => true do |t|
    t.integer  "category_id"
    t.string   "title",       :limit => 300
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sites", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "site_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sites", ["site_id"], :name => "index_user_sites_on_site_id"
  add_index "user_sites", ["user_id"], :name => "index_user_sites_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                :limit => 50,                     :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "firstname",            :limit => 30
    t.string   "lastname",             :limit => 20
    t.string   "phone",                :limit => 12
    t.string   "company",              :limit => 300
    t.boolean  "remember_me"
    t.boolean  "is_admin",                            :default => false, :null => false
    t.integer  "state_id",             :limit => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["firstname", "lastname"], :name => "index_users_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["state_id"], :name => "index_users_on_state_id"

  create_table "zone_ads", :force => true do |t|
    t.integer  "zone_id",    :null => false
    t.integer  "ad_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zone_ads", ["zone_id"], :name => "index_zone_ads_on_zone_id"

  create_table "zones", :force => true do |t|
    t.string   "uuid",       :limit => 36,                     :null => false
    t.integer  "site_id",                                      :null => false
    t.string   "name",       :limit => 300
    t.integer  "width"
    t.integer  "height"
    t.integer  "state_id",   :limit => 3
    t.boolean  "cycle",                     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zones", ["site_id"], :name => "index_zones_on_site_id"
  add_index "zones", ["uuid"], :name => "index_zones_on_uuid"

end
