# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130327172649) do

  create_table "addres_gs", :force => true do |t|
    t.integer  "bomg"
    t.string   "subj"
    t.string   "indx"
    t.string   "okato"
    t.string   "rnname"
    t.string   "npname"
    t.string   "ul"
    t.string   "dom"
    t.string   "korp"
    t.string   "kv"
    t.date     "dreg"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "addres_gs", ["person_id"], :name => "index_addres_gs_on_person_id"

  create_table "addres_ps", :force => true do |t|
    t.string   "subj"
    t.string   "indx"
    t.string   "okato"
    t.string   "rnname"
    t.string   "npname"
    t.string   "ul"
    t.string   "dom"
    t.string   "korp"
    t.string   "kv"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "addres_ps", ["person_id"], :name => "index_addres_ps_on_person_id"

  create_table "ates", :id => false, :force => true do |t|
    t.integer "id",                     :null => false
    t.string  "nameate", :limit => 128
  end

  create_table "ats", :force => true do |t|
    t.string   "type_at",    :limit => 1, :null => false
    t.integer  "kdatemu",                 :null => false
    t.integer  "kdmu",                    :null => false
    t.datetime "date_z"
    t.datetime "date_b",                  :null => false
    t.datetime "date_e"
    t.integer  "person_id",               :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "ats", ["kdatemu", "kdmu"], :name => "index_ats_on_kdatemu_and_kdmu"
  add_index "ats", ["person_id"], :name => "index_ats_on_person_id"

  create_table "docs", :force => true do |t|
    t.string   "doctype"
    t.string   "docser"
    t.string   "docnum"
    t.date     "docdate"
    t.string   "name_vp"
    t.string   "mr"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "docs", ["person_id"], :name => "index_docs_on_person_id"

  create_table "filializations", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "filial_id"
  end

  add_index "filializations", ["filial_id"], :name => "index_filializations_on_filial_id"
  add_index "filializations", ["user_id"], :name => "index_filializations_on_user_id"

  create_table "filials", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flks", :force => true do |t|
    t.integer  "rez"
    t.integer  "at_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "flks", ["at_id"], :name => "index_flks_on_at_id"

  create_table "foreigners", :force => true do |t|
    t.string   "ig_doctype",   :limit => 100
    t.string   "ig_docser",    :limit => 20
    t.string   "ig_docnum",    :limit => 20
    t.date     "ig_docdate"
    t.string   "ig_name_vp",   :limit => 150
    t.date     "ig_startdate"
    t.date     "ig_enddate"
    t.integer  "person_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "foreigners", ["person_id"], :name => "index_foreigners_on_person_id"

  create_table "insurances", :force => true do |t|
    t.string   "ter_st"
    t.string   "enp",        :limit => 16
    t.string   "ogrnsmo"
    t.integer  "erp"
    t.integer  "vizit_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "nsilpus", :force => true do |t|
    t.integer "kdlpu"
    t.string  "ate_id"
    t.string  "namelpu"
    t.integer "kdlpu_ur"
    t.integer "kdate_ur"
    t.integer "status"
    t.integer "kdtype"
  end

  add_index "nsilpus", ["ate_id"], :name => "index_nsilpus_on_ate_id"

  create_table "okatos", :force => true do |t|
    t.string   "kdnpt"
    t.string   "namenpt"
    t.string   "kdobl"
    t.string   "kdate"
    t.string   "okato"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "oksms", :force => true do |t|
    t.string   "kod"
    t.string   "name11"
    t.string   "alfa2"
    t.string   "alfa3"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "old_docs", :force => true do |t|
    t.string   "doctype"
    t.string   "docser"
    t.string   "docnum"
    t.date     "docdate"
    t.string   "name_vp"
    t.string   "mr"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "old_docs", ["person_id"], :name => "index_old_docs_on_person_id"

  create_table "old_people", :force => true do |t|
    t.string   "fam"
    t.string   "im"
    t.string   "ot"
    t.integer  "w"
    t.date     "dr"
    t.integer  "old_enp"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "old_people", ["person_id"], :name => "index_old_people_on_person_id"

  create_table "ops", :force => true do |t|
    t.string   "tip_op",     :limit => 4
    t.boolean  "active",                  :default => false, :null => false
    t.date     "date_uvoln"
    t.integer  "person_id"
    t.integer  "user_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "filial_id"
  end

  add_index "ops", ["active"], :name => "index_ops_on_active"
  add_index "ops", ["created_at"], :name => "index_ops_on_created_at"
  add_index "ops", ["filial_id", "person_id"], :name => "index_ops_on_filial_id_and_person_id", :unique => true
  add_index "ops", ["filial_id"], :name => "index_ops_on_filial_id"
  add_index "ops", ["person_id"], :name => "index_ops_on_person_id"
  add_index "ops", ["updated_at"], :name => "index_ops_on_updated_at"
  add_index "ops", ["user_id", "person_id"], :name => "index_ops_on_user_id_and_person_id", :unique => true
  add_index "ops", ["user_id"], :name => "index_ops_on_user_id"

  create_table "people", :force => true do |t|
    t.string   "fam",        :limit => 40, :null => false
    t.string   "im",         :limit => 40, :null => false
    t.string   "ot",         :limit => 40, :null => false
    t.integer  "w",                        :null => false
    t.date     "dr",                       :null => false
    t.integer  "true_dr",                  :null => false
    t.string   "c_oksm"
    t.string   "ss"
    t.string   "phone",      :limit => 40
    t.string   "email",      :limit => 50
    t.string   "status",     :limit => 3
    t.date     "ddeath"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "people", ["dr"], :name => "index_people_on_dr"
  add_index "people", ["fam"], :name => "index_people_on_fam"

  create_table "personbs", :force => true do |t|
    t.string   "type"
    t.binary   "photo"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "personbs", ["person_id"], :name => "index_personbs_on_person_id"

  create_table "polis", :force => true do |t|
    t.integer  "vpolis",                     :null => false
    t.string   "npolis",       :limit => 20
    t.string   "spolis",       :limit => 10
    t.datetime "dbeg"
    t.date     "dend"
    t.date     "dstop"
    t.date     "datepp"
    t.date     "datepolis"
    t.integer  "insurance_id",               :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "polis", ["insurance_id"], :name => "index_polis_on_insurance_id"

  create_table "representatives", :force => true do |t|
    t.string   "fam"
    t.string   "im"
    t.string   "ot"
    t.string   "parent"
    t.string   "doctype"
    t.string   "docser"
    t.string   "docnum"
    t.date     "docdate"
    t.string   "phone"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "representatives", ["person_id"], :name => "index_representatives_on_person_id"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "streets", :force => true do |t|
    t.integer "old_id"
    t.string  "name"
  end

  add_index "streets", ["name"], :name => "index_streets_on_name"

  create_table "subektis", :force => true do |t|
    t.string   "kod_tf"
    t.string   "subname"
    t.string   "kod_okato"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tipdocs", :force => true do |t|
    t.string   "iddoc"
    t.string   "docname"
    t.string   "docser"
    t.string   "docnum"
    t.date     "datebeg"
    t.date     "dateend"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "uploads", :force => true do |t|
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["user_id", "role_id"], :name => "index_user_roles_on_user_id_and_role_id"

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_sessions", ["session_id"], :name => "index_user_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name",                :default => "", :null => false
    t.string   "login",                               :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "password_salt",                       :null => false
    t.string   "email",                               :null => false
    t.string   "persistence_token",                   :null => false
    t.string   "single_access_token",                 :null => false
    t.string   "perishable_token",                    :null => false
    t.integer  "login_count",         :default => 0,  :null => false
    t.integer  "failed_login_count",  :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "filial_id"
  end

  add_index "users", ["filial_id"], :name => "index_users_on_filial_id"

  create_table "vizits", :force => true do |t|
    t.datetime "dvizit",                  :null => false
    t.string   "method",     :limit => 1, :null => false
    t.string   "petition",   :limit => 1, :null => false
    t.integer  "rsmo"
    t.integer  "rpolis"
    t.integer  "fpolis"
    t.integer  "person_id",               :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "vizits", ["person_id"], :name => "index_vizits_on_person_id"

end
