# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100305234733) do

  create_table "book_lines", :force => true do |t|
    t.text     "line"
    t.integer  "source"
    t.integer  "linenum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contexts", :force => true do |t|
    t.string   "word"
    t.text     "before"
    t.text     "after"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_players", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "wordlist_id"
    t.boolean  "finished"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currentword"
  end

  create_table "intersects", :force => true do |t|
    t.integer  "seta"
    t.integer  "setb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multiple_choices", :force => true do |t|
    t.string   "choice1"
    t.string   "choice2"
    t.string   "choice3"
    t.string   "choice4"
    t.integer  "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_intersection"
    t.integer  "intersection_id"
  end

  create_table "searches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "wordlists", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wordlists_words", :id => false, :force => true do |t|
    t.integer "word_id"
    t.integer "wordlist_id"
  end

  create_table "words", :force => true do |t|
    t.string   "word"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
